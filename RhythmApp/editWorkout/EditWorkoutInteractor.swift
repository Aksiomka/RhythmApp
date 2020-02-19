//
//  EditWorkoutInteractor.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 26/08/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


class EditWorkoutInteractor: EditWorkoutInteractorProtocol {
    
    weak var output: EditWorkoutInteractorOutputProtocol?
    
    private let disposeBag = DisposeBag()
    private let workoutModel = WorkoutModel(db: DB.sharedInstance)
    
    func loadWorkout(workoutId: Int) {
        workoutModel.getWorkout(workoutId: workoutId)
            .subscribe (onNext: { [weak self] workout in
                self?.output?.processWorkout(workout: workout)
            })
            .disposed(by: disposeBag)
    }
    
    func createWorkout(_ workout: Workout) {
        workoutModel.createWorkout(workout)
            .subscribe(onCompleted: { [weak self] in
                self?.output?.workoutCreated()
                }, onError: { _ in })
            .disposed(by: disposeBag)
    }
    
    func updateWorkout(_ workout: Workout) {
        workoutModel.updateWorkout(workout)
            .subscribe(onCompleted: { [weak self] in
                self?.output?.workoutUpdated()
                }, onError: { _ in })
            .disposed(by: disposeBag)
    }
    
}
