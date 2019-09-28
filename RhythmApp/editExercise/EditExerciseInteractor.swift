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
    
    func loadExercise(exerciseId: Int?, workoutId: Int) {
        let exerciseObservable = exerciseId != nil ?
            ExerciseModel.getExercise(exerciseId: exerciseId!) : Observable<Exercise?>.just(Exercise())
        Observable.combineLatest(
            exerciseObservable,
            WorkoutModel.getWorkout(workoutId: workoutId))
            .subscribe (onNext: { [weak self] (exercise, workout) in
                self?.output?.processExercise(exercise: exercise, workout: workout)
            })
            .disposed(by: disposeBag)
    }
    
    func createExercise(_ exercise: Exercise) {
        ExerciseModel.createExercise(exercise)
            .subscribe(onCompleted: { [weak self] in
                self?.output?.exerciseCreated()
                }, onError: { _ in })
            .disposed(by: disposeBag)
    }
    
    func updateExercise(_ exercise: Exercise) {
        ExerciseModel.updateExercise(exercise)
            .subscribe(onCompleted: { [weak self] in
                self?.output?.exerciseUpdated()
                }, onError: { _ in })
            .disposed(by: disposeBag)
    }
    
}
