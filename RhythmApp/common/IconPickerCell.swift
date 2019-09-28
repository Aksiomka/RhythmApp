//
//  IconPickerCell.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 31/08/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import UIKit

class IconPickerCell: UICollectionViewCell {

    @IBOutlet private weak var iconView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconView.layer.cornerRadius = iconView.frame.width / 2
        iconView.layer.borderColor = UIColor.white.cgColor
    }
    
    func setIcon(icon: WorkoutIcon, isChosen: Bool) {
        iconView.image = WorkoutIconUtil.getUIImageForWorkoutIcon(icon)
        iconView.layer.borderWidth = isChosen ? 2.0 : 0.0
    }
    
}
