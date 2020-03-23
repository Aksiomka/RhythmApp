//
//  ColorPicker.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 18/08/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import UIKit


@IBDesignable class ColorPicker: UIView {
    
    private var collectionView: InfiniteHorizontalCollectionView<WorkoutColor>!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func setChosenColor(chosenColor: WorkoutColor) {
        collectionView.setChosenItem(chosenItem: chosenColor)
    }
    
    func setColorClickCallback(callback: @escaping (WorkoutColor) -> Void) {
        collectionView.itemClickCallback = callback
    }
    
    private func initialize() {
        let colors = WorkoutColor.allCases
        let rect = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        collectionView = InfiniteHorizontalCollectionView(frame: rect, items: colors, cellNibName: "ColorPickerCell",
                                                          setCellDataCallback: { cell, item, chosenItem in
                                                            (cell as? ColorPickerCell)?.setWorkoutColor(color: item, isChosen: item == chosenItem)
        })
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        leftAnchor.constraint(equalTo: collectionView.leftAnchor, constant: 0).isActive = true
        rightAnchor.constraint(equalTo: collectionView.rightAnchor, constant: 0).isActive = true
        topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 0).isActive = true
        bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 0).isActive = true
    }
    
}
