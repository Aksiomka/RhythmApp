//
//  EditExerciseInteractor.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 23/09/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


class EditExerciseInteractor: EditExerciseInteractorProtocol {
    
    weak var output: EditExerciseInteractorOutputProtocol?
    
    private let disposeBag = DisposeBag()
    private let exerciseModel = ExerciseModel()
    private let workoutModel = WorkoutModel()
    
    func loadExercise(exerciseId: Int?, workoutId: Int) {
        if let exerciseId = exerciseId {
            if let exerciseObservable = exerciseModel.getExercise(exerciseId: exerciseId),
                let workoutObservable = workoutModel.getWorkout(workoutId: workoutId) {
                Observable.combineLatest(
                    exerciseObservable,
                    workoutObservable)
                .subscribe (onNext: { [weak self] (exercise, workout)  in
                    self?.output?.processExercise(exercise: exercise, workout: workout)
                })
                .disposed(by: disposeBag)
            } else {
                output?.processExercise(exercise: nil, workout: nil)
            }
        } else {
            if let workoutObservable = workoutModel.getWorkout(workoutId: workoutId) {
                workoutObservable.subscribe (onNext: { [weak self] workout in
                    self?.output?.processExercise(exercise: Exercise(), workout: workout)
                })
                .disposed(by: disposeBag)
            } else {
                output?.processExercise(exercise: Exercise(), workout: nil)
            }
        }
    }
    
    func createExercise(_ exercise: Exercise) {
        exerciseModel.createExercise(exercise)
            .subscribe(onCompleted: { [weak self] in
                self?.output?.exerciseCreated()
                }, onError: { _ in })
            .disposed(by: disposeBag)
    }
    
    func updateExercise(_ exercise: Exercise) {
        exerciseModel.updateExercise(exercise)
            .subscribe(onCompleted: { [weak self] in
                self?.output?.exerciseUpdated()
                }, onError: { _ in })
            .disposed(by: disposeBag)
    }
    
}
