//
//  InfiniteHorizontalCollectionView.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 01/09/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import UIKit


class InfiniteHorizontalCollectionView<Item: RawRepresentable>: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private let NUMBER_OF_CELLS = 10000
    
    var itemClickCallback: (Item) -> Void = { _ in }
    
    private var items: [Item]
    private var chosenItem: Item? = nil
    private var setCellDataCallback: (UICollectionViewCell, Item, Item?) -> Void
    
    init(frame: CGRect, items: [Item], cellNibName: String, setCellDataCallback: @escaping (UICollectionViewCell, Item, Item?) -> Void) {
        self.items = items
        self.setCellDataCallback = setCellDataCallback
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 70, height: frame.size.height)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        
        super.init(frame: frame, collectionViewLayout: layout)
        
        dataSource = self
        delegate = self
        register(UINib(nibName: cellNibName, bundle: nil), forCellWithReuseIdentifier: "ItemPickerCell")
        showsHorizontalScrollIndicator = false
        backgroundColor = UIColor.clear
        
        reloadData()
        
        DispatchQueue.main.async { [unowned self] in
            self.scrollToItem(at: IndexPath(row: self.NUMBER_OF_CELLS / 2, section: 0), at: .centeredHorizontally, animated: false)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This method is not implemented")
    }
    
    func setChosenItem(chosenItem: Item) {
        self.chosenItem = chosenItem
        reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NUMBER_OF_CELLS
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row % items.count]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemPickerCell", for: indexPath)
        setCellDataCallback(cell, item, chosenItem)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row % items.count]
        itemClickCallback(item)
    }
    
}

