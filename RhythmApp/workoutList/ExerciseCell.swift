//
//  ExerciseCell.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 28/09/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import UIKit

class ExerciseCell: UICollectionViewCell {

    @IBOutlet private weak var bgView: UIView!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var progressView: ProgressView!
    
    var playButtonClickCallback: () -> Void = {}
    private var exerciseId = 0

    func setData(exercise: ExerciseItem) {
        exerciseId = exercise.id
        nameLabel.text = exercise.name
        durationLabel.text = TimeUtil.formatSeconds(seconds: exercise.remainingSeconds)
        button.setImage(UIImage(named: exercise.isPlaying ? "pause" : "play"), for: .normal)
    }
    
    override func dragStateDidChange(_ dragState: UICollectionViewCell.DragState) {
        if dragState == .none {
            contentView.backgroundColor = UIColor.clear
        } else {
            contentView.backgroundColor = UIColor.gray
        }
    }
    
    @IBAction func onButtonClick(_ sender: UIButton) {
        playButtonClickCallback()
    }
    
    func exerciseStarted(exerciseId: Int, currentTimeInSeconds: TimeInterval, durationInSeconds: TimeInterval) {
        if self.exerciseId == exerciseId {
            let percentage = currentTimeInSeconds * 100 / durationInSeconds
            progressView.startAnimation(percentage: Int(percentage), duration: durationInSeconds - currentTimeInSeconds)
        }
    }
    
    func exercisePaused(exerciseId: Int, currentTimeInSeconds: TimeInterval, durationInSeconds: TimeInterval) {
        if self.exerciseId == exerciseId {
            let percentage = currentTimeInSeconds * 100 / durationInSeconds
            progressView.stopAnimation(percentage: Int(percentage))
        }
    }
    
    func exerciseStopped(exerciseId: Int) {
        if self.exerciseId == exerciseId {
            progressView.stopAnimation(percentage: 100)
        }
    }
}
