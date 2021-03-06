//
//  ColorPickerCell.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 19/03/2020.
//  Copyright © 2020 Svetlana Gladysheva. All rights reserved.
//

import UIKit

class ColorPickerCell: UICollectionViewCell {

    @IBOutlet weak var colorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorView.layer.borderColor = UIColor.white.cgColor
    }
    
    func setWorkoutColor(color: WorkoutColor, isChosen: Bool) {
        colorView.backgroundColor = WorkoutColorUtil.getUIColorForWorkoutColor(color)
        colorView.layer.borderWidth = isChosen ? 2.0 : 0.0
        colorView.layer.cornerRadius = isChosen ? contentView.frame.height / 2 : 0
    }

}
