//
//  IconPicker.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 31/08/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import UIKit


@IBDesignable class IconPicker: UIView {
    
    private var collectionView: InfiniteHorizontalCollectionView<WorkoutIcon>!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func setChosenItem(chosenItem: WorkoutIcon) {
        collectionView.setChosenItem(chosenItem: chosenItem)
    }
    
    func setIconClickCallback(callback: @escaping (WorkoutIcon) -> Void) {
        collectionView.itemClickCallback = callback
    }
    
    private func initialize() {
        let icons = WorkoutIcon.allValues
        let rect = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        collectionView = InfiniteHorizontalCollectionView(frame: rect, items: icons, cellNibName: "IconPickerCell",
                                                          setCellDataCallback: { cell, item, chosenItem in
                                                            (cell as? IconPickerCell)?.setIcon(icon: item, isChosen: item == chosenItem)
        })
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        leftAnchor.constraint(equalTo: collectionView.leftAnchor, constant: 0).isActive = true
        rightAnchor.constraint(equalTo: collectionView.rightAnchor, constant: 0).isActive = true
        topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 0).isActive = true
        bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 0).isActive = true
    }
    
}
