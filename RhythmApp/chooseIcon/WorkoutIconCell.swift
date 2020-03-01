//
//  WorkoutIconCell.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 01/03/2020.
//  Copyright © 2020 Svetlana Gladysheva. All rights reserved.
//

import UIKit

class WorkoutIconCell: UITableViewCell {

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var checkImageView: UIImageView!
    
    func setData(icon: WorkoutIcon, selected: Bool) {
        iconImageView.image = WorkoutIconUtil.getUIImageForWorkoutIcon(icon)
        checkImageView.isHidden = !selected
    }
    
}
