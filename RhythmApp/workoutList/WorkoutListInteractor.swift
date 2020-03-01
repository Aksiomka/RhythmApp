//
//  WorkoutListInteractor.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 17/08/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


class WorkoutListInteractor: WorkoutListInteractorProtocol {
    
    weak var output: WorkoutListInteractorOutputProtocol?
    
    private let disposeBag = DisposeBag()
    private let workoutModel = WorkoutModel()
    private let exerciseModel = ExerciseModel()
    
    func loadWorkouts() {
        Observable.combineLatest(
            workoutModel.getWorkouts(),
            exerciseModel.getExercises())
            .subscribe(onNext: { [weak self] (workouts, exercises) in
                self?.output?.processWorkouts(workouts: workouts, exercises: exercises)
            })
            .disposed(by: disposeBag)
    }
    
    func deleteWorkout(workoutId: Int) {
        workoutModel.deleteWorkout(workoutId: workoutId)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.asyncInstance)
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    func moveExercise(workoutId: Int, oldPosition: Int, newPosition: Int) {
        exerciseModel.moveExercise(workoutId: workoutId, oldPosition: oldPosition, newPosition: newPosition)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.asyncInstance)
            .subscribe()
            .disposed(by: disposeBag)
    }
}
