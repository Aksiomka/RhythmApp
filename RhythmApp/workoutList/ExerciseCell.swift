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
    

    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = bgView.frame.height / 2
        bgView.layer.borderColor = UIColor.white.cgColor
        bgView.layer.borderWidth = 3.0
    }
    
    func setData(exercise: Exercise) {
        nameLabel.text = exercise.name
        durationLabel.text = exercise.durationInSeconds.description
    }
    
    override func dragStateDidChange(_ dragState: UICollectionViewCell.DragState) {
        if dragState == .none {
            contentView.backgroundColor = UIColor.clear
        } else {
            contentView.backgroundColor = UIColor.gray
        }
    }
}
