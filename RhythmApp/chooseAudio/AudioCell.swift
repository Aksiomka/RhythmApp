//
//  AudioCell.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 18/10/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import UIKit

class AudioCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var checkImageView: UIImageView!
    
    var playButtonClickCallback: () -> Void = {}
    
    
    func setData(name: String, isPlaying: Bool, selected: Bool) {
        nameLabel.text = name
        playButton.setImage(UIImage(named: isPlaying ? "pause" : "play-circle"), for: .normal)
        checkImageView.isHidden = !selected
    }
    
    @IBAction func onPlayButtonClick(_ sender: UIButton) {
        playButtonClickCallback()
    }
    
}
