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
    private let exerciseModel = ExerciseModel(db: DB.sharedInstance)
    private let workoutModel = WorkoutModel(db: DB.sharedInstance)
    
    func loadExercise(exerciseId: Int?, workoutId: Int) {
        let exerciseObservable = exerciseId != nil ?
            exerciseModel.getExercise(exerciseId: exerciseId!) : Observable<Exercise?>.just(Exercise())
        Observable.combineLatest(
            exerciseObservable,
            workoutModel.getWorkout(workoutId: workoutId))
            .subscribe (onNext: { [weak self] (exercise, workout) in
                self?.output?.processExercise(exercise: exercise, workout: workout)
            })
            .disposed(by: disposeBag)
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
