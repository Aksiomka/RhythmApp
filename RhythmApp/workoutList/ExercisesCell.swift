//
//  ExercisesCell.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 28/09/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import UIKit

class ExercisesCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

    private var collectionView: UICollectionView!
    
    private var exercises: [Exercise] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 90, height: 90)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;

        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "ExerciseCell", bundle: nil), forCellWithReuseIdentifier: "ExerciseCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
    }
    
    func setData(exercises: [Exercise]) {
        self.exercises = exercises
        collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exercises.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExerciseCell", for: indexPath) as! ExerciseCell
        cell.setData(exercise: exercises[indexPath.row])
        return cell
    }
    
    
}
