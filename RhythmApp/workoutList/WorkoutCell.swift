//
//  WorkoutCell.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 17/08/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import UIKit

class WorkoutCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var iconView: UIImageView!
    @IBOutlet private weak var bgView: UIView!
    @IBOutlet private weak var editButton: UIButton!
    
    var editWorkoutButtonClickCallback: () -> Void = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 10
        bgView.layer.masksToBounds = true
        
        iconView.layer.cornerRadius = iconView.frame.width / 2
        iconView.layer.borderWidth = 2.0
        iconView.layer.borderColor = UIColor.white.cgColor
        
        selectionStyle = .none
    }
    
    func setWorkout(_ workout: Workout) {
        nameLabel.text = workout.name
        descriptionLabel.text = workout.descr
        iconView.image = WorkoutIconUtil.getUIImageForWorkoutIcon(workout.icon)
        bgView.backgroundColor = WorkoutColorUtil.getUIColorForWorkoutColor(workout.color)
    }
    
    @IBAction func onEditWorkoutButtonClick(_ sender: UIButton) {
        editWorkoutButtonClickCallback()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        let bgColor = bgView.backgroundColor
        bgView.backgroundColor = highlighted ? bgColor?.withAlphaComponent(0.8) : bgColor?.withAlphaComponent(0.5)
    }
    
}
