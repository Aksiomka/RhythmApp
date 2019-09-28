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
    
    func loadWorkouts() {
        Observable.combineLatest(
            WorkoutModel.getWorkouts(),
            ExerciseModel.getExercises())
            .subscribe(onNext: { [weak self] (workouts, exercises) in
                self?.output?.processWorkouts(workouts: workouts, exercises: exercises)
            })
            .disposed(by: disposeBag)
    }
    
    func deleteWorkout(workoutId: Int) {
        WorkoutModel.deleteWorkout(workoutId: workoutId)
            .subscribe(onCompleted: { [weak self] in
                self?.output?.workoutDeleted()
                }, onError: { _ in })
            .disposed(by: disposeBag)
    }
}
