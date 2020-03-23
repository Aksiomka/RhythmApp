//
//  AudioPlayer.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 18/10/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import Foundation
import AVFoundation


class AudioPlayer: NSObject, AVAudioPlayerDelegate {
    
    private var player: AVAudioPlayer? = nil
    private var playingAudioType: AudioType? = nil
    
    var audioPlayingFinishedCallback: () -> Void = {}
    
    static var sharedInstance = AudioPlayer()
    
    private override init() {}
    
    func play(audioType: AudioType) {
        let fileName = AudioTypeUtil.getFileNameForAudioType(audioType)
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else { return }

        stop()
        
        do {
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            player?.delegate = self
            player?.play()
            playingAudioType = audioType
        } catch let error {
            NSLog(error.localizedDescription)
        }
    }
    
    func pause() {
        player?.pause()
    }
    
    func resume() {
        player?.play()
    }
    
    func stop() {
        player?.stop()
        player = nil
        playingAudioType = nil
    }
    
    func isPlaying(audioType: AudioType) -> Bool {
        return playingAudioType == audioType && player?.isPlaying == true
    }
    
    func getCurrentTime() -> TimeInterval {
        return player?.currentTime ?? 0
    }
    
    func getDuration() -> TimeInterval {
        return player?.duration ?? 0
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.player = nil
        playingAudioType = nil
        audioPlayingFinishedCallback()
    }
    
}
