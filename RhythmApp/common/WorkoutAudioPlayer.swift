//
//  WorkoutAudioPlayer.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 17/03/2020.
//  Copyright © 2020 Svetlana Gladysheva. All rights reserved.
//

import Foundation
import AVFoundation


protocol WorkoutAudioPlayerDelegate {
    func exerciseStarted(exerciseId: Int, currentTimeInSeconds: TimeInterval, durationInSeconds: TimeInterval)
    func exercisePaused(exerciseId: Int, currentTimeInSeconds: TimeInterval, durationInSeconds: TimeInterval)
    func exerciseCompleted(exerciseId: Int)
    func remainingDurationChanged(exerciseId: Int)
}

class WorkoutAudioPlayer {
    
    private var exerciseAudioItems: [ExerciseAudioItem] = []
    private var timer: Timer?
    private var player: AudioPlayer = AudioPlayer.sharedInstance
    private var numberOfRepeats = 0
    
    var delegate: WorkoutAudioPlayerDelegate? = nil
    
    
    init() {
        player.audioPlayingFinishedCallback = { [unowned self] in
            if self.getCurrentAudioItem() != nil {
                self.numberOfRepeats += 1
                self.playNext(isNew: false)
            }
        }
    }
    
    func playAudios(exerciseAudioItems: [ExerciseAudioItem]) {
        self.exerciseAudioItems = exerciseAudioItems
        numberOfRepeats = 0
        playNext(isNew: true)
    }
    
    func pause() {
        player.pause()
        if let currentAudioItem = getCurrentAudioItem() {
            let currentTime = player.getCurrentTime() + Double(numberOfRepeats) * player.getDuration()
            delegate?.exercisePaused(exerciseId: currentAudioItem.exerciseId, currentTimeInSeconds: currentTime, durationInSeconds: TimeInterval(currentAudioItem.durationInSeconds))
        }
    }
    
    func resume() {
        player.resume()
        if let currentAudioItem = getCurrentAudioItem() {
            let currentTime = player.getCurrentTime() + Double(numberOfRepeats) * player.getDuration()
            delegate?.exerciseStarted(exerciseId: currentAudioItem.exerciseId, currentTimeInSeconds: currentTime, durationInSeconds: TimeInterval(currentAudioItem.durationInSeconds))
        }
    }
    
    func isPlaying(exerciseId: Int) -> Bool {
        if let currentAudioItem = getCurrentAudioItem() {
            return currentAudioItem.exerciseId == exerciseId && player.isPlaying(audioType: currentAudioItem.audio)
        }
        return false
    }
    
    func isPaused(exerciseId: Int) -> Bool {
        if let currentAudioItem = getCurrentAudioItem() {
            return currentAudioItem.exerciseId == exerciseId && !player.isPlaying(audioType: currentAudioItem.audio)
        }
        return false
    }
    
    func getRemainingDuration() -> Int {
        if let currentAudioItem = getCurrentAudioItem() {
            let currentTime = player.getCurrentTime() + Double(numberOfRepeats) * player.getDuration()
            return currentAudioItem.durationInSeconds - Int(currentTime)
        }
        return 0
    }
    
    private func playNext(isNew: Bool) {
        if let nextAudioItem = exerciseAudioItems.first {
            play(exerciseAudioItem: nextAudioItem)
            if isNew {
                delegate?.exerciseStarted(exerciseId: nextAudioItem.exerciseId, currentTimeInSeconds: player.getCurrentTime(), durationInSeconds: TimeInterval(nextAudioItem.durationInSeconds))
            }
        }
    }
    
    private func play(exerciseAudioItem: ExerciseAudioItem) {
        player.play(audioType: exerciseAudioItem.audio)
        startTimer()
    }
    
    private func getCurrentAudioItem() -> ExerciseAudioItem? {
        return exerciseAudioItems.first
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(onTimerFire), userInfo: nil, repeats: true)
    }
    
    private func stopTimer() {
        timer?.invalidate()
    }
    
    @objc private func onTimerFire() {
        if let currentAudioItem = getCurrentAudioItem() {
            let remainingDuration = getRemainingDuration()
            delegate?.remainingDurationChanged(exerciseId: currentAudioItem.exerciseId)
            
            if remainingDuration <= 0 {
                player.stop()
                stopTimer()
                numberOfRepeats = 0
                self.exerciseAudioItems.remove(at: 0)
                self.delegate?.exerciseCompleted(exerciseId: currentAudioItem.exerciseId)
                playNext(isNew: true)
            }
        }
    }
}

struct ExerciseAudioItem {
    var exerciseId: Int
    var audio: AudioType
    var durationInSeconds: Int
}

