//
//  AddExerciseCell.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 29/09/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import UIKit

class AddExerciseCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var addImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.layer.cornerRadius = bgView.frame.height / 2
        bgView.layer.borderColor = UIColor.white.cgColor
        bgView.layer.borderWidth = 1.0
    }

}
