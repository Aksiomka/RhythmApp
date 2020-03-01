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
    
    func loadExercise(exerciseId: Int?) {
        if let exerciseId = exerciseId {
            if let exerciseObservable = exerciseModel.getExercise(exerciseId: exerciseId) {
                exerciseObservable.subscribe (onNext: { [weak self] exercise in
                    self?.output?.processExercise(exercise: exercise)
                })
                .disposed(by: disposeBag)
            } else {
                output?.processExercise(exercise: nil)
            }
        } else {
            output?.processExercise(exercise: Exercise())
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
