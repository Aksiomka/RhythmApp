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
    

    func setData(exercise: Exercise) {
        nameLabel.text = exercise.name
        durationLabel.text = exercise.durationInSeconds.description
    }
}
