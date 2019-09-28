//
//  AddWorkoutCell.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 17/08/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import UIKit

class AddWorkoutCell: UITableViewCell {

    var addWorkoutButtonClickCallback: () -> Void = {}
    
    @IBOutlet private weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.backgroundColor = UIColor.init(named: "Gray")!
        bgView.layer.cornerRadius = 10
        bgView.layer.masksToBounds = true
        
        selectionStyle = .none
    }
    
    @IBAction func onAddWorkoutButtonClick(_ sender: UIButton) {
        addWorkoutButtonClickCallback()
    }
    
}
