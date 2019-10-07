//
//  ExercisesCell.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 28/09/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import UIKit

class ExercisesCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDragDelegate, UICollectionViewDropDelegate {

    static let CELL_HEIGHT: CGFloat = 110
    static let MIN_SPACING: CGFloat = 10
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var exercises: [Exercise] = []
    
    var addExerciseCellClickCallback: () -> Void = {}
    var exerciseMovedCallback: (_ oldPosition: Int, _ newPosition: Int) -> Void = { _, _ in }
    var playButtonClickCallback: (_ exerciseId: Int, _ audioType: AudioType) -> Void = { _, _ in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "ExerciseCell", bundle: nil), forCellWithReuseIdentifier: "ExerciseCell")
        collectionView.register(UINib(nibName: "AddExerciseCell", bundle: nil), forCellWithReuseIdentifier: "AddExerciseCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addSubview(collectionView)
        
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        collectionView.dragInteractionEnabled = true
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
            let exercise = exercises[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExerciseCell", for: indexPath) as! ExerciseCell
            cell.setData(exercise: exercise)
            cell.playButtonClickCallback = { [unowned self] in
                self.playButtonClickCallback(exercise.id, exercise.audio)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.width / 3 - 16, height: ExercisesCell.CELL_HEIGHT)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ExercisesCell.MIN_SPACING
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return ExercisesCell.MIN_SPACING
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == exercises.count {
            addExerciseCellClickCallback()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        if indexPath.row == exercises.count {
            return []
        }
        let exercise = exercises[indexPath.row]
        let itemProvider = NSItemProvider(object: NSString(string: exercise.id.description))
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = exercise
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else { return }
        collectionView.performBatchUpdates({
            for item in coordinator.items {
                if let localObject = item.dragItem.localObject as? Exercise {
                    if let sourceIndexPath = item.sourceIndexPath, sourceIndexPath.row != exercises.count && destinationIndexPath.row != exercises.count {
                        
                        exercises.remove(at: sourceIndexPath.item)
                        collectionView.deleteItems(at: [sourceIndexPath])
                    
                        exercises.insert(localObject, at: destinationIndexPath.item)
                        coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
                        collectionView.insertItems(at: [destinationIndexPath])
                        
                        exerciseMovedCallback(sourceIndexPath.item, destinationIndexPath.item)
                    }
                }
            }
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
        if proposedIndexPath.row == exercises.count {
            return originalIndexPath
        } else {
            return proposedIndexPath
        }
    }
    
    static func getHeightForExercises(exercises: [Exercise]) -> CGFloat {
        return CGFloat(exercises.count / 3) * (ExercisesCell.CELL_HEIGHT + ExercisesCell.MIN_SPACING) + ExercisesCell.CELL_HEIGHT
    }
    
}
