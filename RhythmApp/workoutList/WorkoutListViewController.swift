//
//  WorkoutListViewController.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 17/08/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources


class WorkoutListViewController: UIViewController, WorkoutListViewProtocol, UITableViewDelegate {
    
    var presenter: WorkoutListPresenterProtocol!
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewDidLoad()
        
        title = "My workouts"
        
        tableView.register(UINib(nibName: "WorkoutCell", bundle: nil), forCellReuseIdentifier: "workout")
        tableView.register(UINib(nibName: "ExercisesCell", bundle: nil), forCellReuseIdentifier: "exercises")
        tableView.register(UINib(nibName: "AddWorkoutCell", bundle: nil), forCellReuseIdentifier: "addWorkout")
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func setWorkoutsDriver(workoutsDriver: Driver<[WorkoutWithExercises]>) {
        let dataSource = RxTableViewSectionedReloadDataSource<MultipleSectionModel>(configureCell: { (dataSource, table, idxPath, _) in
            switch dataSource[idxPath] {
            case let .WorkoutItem(workout):
                let cell: WorkoutCell = table.dequeueReusableCell(withIdentifier: "workout", for: idxPath) as! WorkoutCell
                cell.setWorkout(workout)
                return cell
            case let .ExercisesItem(exercises):
                let cell: ExercisesCell = table.dequeueReusableCell(withIdentifier: "exercises", for: idxPath) as! ExercisesCell
                cell.setData(exercises: exercises)
                return cell
            case .AddWorkoutItem:
                let cell: AddWorkoutCell = table.dequeueReusableCell(withIdentifier: "addWorkout", for: idxPath) as! AddWorkoutCell
                cell.addWorkoutButtonClickCallback = { [weak self] in
                    self?.presenter.onNewWorkoutButtonClick()
                }
                return cell
            }
        })
        dataSource.canEditRowAtIndexPath = { dataSource, indexPath in
            switch dataSource[indexPath] {
            case .WorkoutItem(_):
                return true
            case .ExercisesItem(_):
                return false
            case .AddWorkoutItem:
                return false
            }
        }
        
        workoutsDriver
            .map { workoutsWithExercises in
                var items: [SectionItem] = []
                for workoutWithExercises in workoutsWithExercises {
                    items.append(SectionItem.WorkoutItem(workout: workoutWithExercises.workout))
                    items.append(SectionItem.ExercisesItem(exercises: workoutWithExercises.exercises))
                }
                items.append(SectionItem.AddWorkoutItem)
                return [MultipleSectionModel(items: items)]
            }
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx
            .itemSelected
            .map { indexPath in
                return (indexPath, dataSource[indexPath])
            }
            .subscribe(onNext: { [weak self] pair in
                switch pair.1 {
                case let .WorkoutItem(workout):
                    self?.presenter?.onWorkoutSelected(workoutId: workout.id)
                case .ExercisesItem(_):
                    // do nothing
                    break
                case .AddWorkoutItem:
                    // do nothing
                    break
                }
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemDeleted
            .map { indexPath in
                return (indexPath, dataSource[indexPath])
            }
            .subscribe(onNext: { [weak self] pair in
                switch pair.1 {
                case let .WorkoutItem(workout):
                    self?.presenter?.onWorkoutDeleteButtonClick(workoutId: workout.id)
                case .ExercisesItem(_):
                    // do nothing
                    break
                case .AddWorkoutItem:
                    // do nothing
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
}

enum SectionItem {
    case WorkoutItem(workout: Workout)
    case ExercisesItem(exercises: [Exercise])
    case AddWorkoutItem
}

class MultipleSectionModel: SectionModelType {
    typealias Item = SectionItem
    
    var items: [SectionItem]
    
    required init(original: MultipleSectionModel, items: [SectionItem]) {
        self.items = items
    }
    
    init(items: [SectionItem]) {
        self.items = items
    }
}