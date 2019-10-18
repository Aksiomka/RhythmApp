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
    
    private var playingExerciseId: Int?
    private var playingAudioType: AudioType?
    
    private var player: AVAudioPlayer? = nil
    
    static let sharedInstance = AudioPlayer()
    
    
    func playAudioFromExercise(exerciseId: Int, audioType: AudioType) {
        if let player = player, playingExerciseId == exerciseId {
            player.play()
        } else {
            playingExerciseId = exerciseId
            playAudio(audioType: audioType)
        }
    }
    
    func playAudio(audioType: AudioType) {
        let fileName = AudioTypeUtil.getFileNameForAudioType(audioType)
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else { return }

        stopAudio()
        
        do {
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            player?.play()
        } catch let error {
            NSLog(error.localizedDescription)
        }
    }
    
    func pauseAudio() {
        player?.pause()
    }
    
    func stopAudio() {
        player?.stop()
        player = nil
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
    }
    
}
