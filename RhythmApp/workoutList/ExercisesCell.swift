//
//  ExercisesCell.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 28/09/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import UIKit

class ExercisesCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    static let CELL_HEIGHT: CGFloat = 110
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var exercises: [Exercise] = []
    
    var addExerciseCellClickCallback: () -> Void = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "ExerciseCell", bundle: nil), forCellWithReuseIdentifier: "ExerciseCell")
        collectionView.register(UINib(nibName: "AddExerciseCell", bundle: nil), forCellWithReuseIdentifier: "AddExerciseCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addSubview(collectionView)
    }
    
    func setData(exercises: [Exercise]) {
        self.exercises = exercises
        collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exercises.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == exercises.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddExerciseCell", for: indexPath) as! AddExerciseCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExerciseCell", for: indexPath) as! ExerciseCell
            cell.setData(exercise: exercises[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.width / 3 - 16, height: ExercisesCell.CELL_HEIGHT)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == exercises.count {
            addExerciseCellClickCallback()
        }
    }
    
    static func getHeightForExercises(exercises: [Exercise]) -> CGFloat {
        return CGFloat(((exercises.count + 1) / 3) + 1) * ExercisesCell.CELL_HEIGHT
    }
    
}
