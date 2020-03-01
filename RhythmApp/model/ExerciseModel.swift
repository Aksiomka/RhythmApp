//
//  ExerciseModel.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 23/09/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import Foundation
import RealmSwift
import RxCocoa
import RxSwift
import RxRealm


class ExerciseModel: BaseModel {
    
    private let exerciseDao = ExerciseDao()
    
    func getExercises() -> Observable<[Exercise]> {
        let result = exerciseDao.getExercises()
        return Observable.array(from: result)
    }
    
    func getExercisesByWorkoutId(_ workoutId: Int) -> Observable<[Exercise]> {
        let result = exerciseDao.getExercisesByWorkoutId(workoutId)
        return Observable.array(from: result)
    }
    
    func getExercise(exerciseId: Int) -> Observable<Exercise>? {
        if let exercise = exerciseDao.getExerciseById(id: exerciseId) {
            return Observable.from(object: exercise)
        }
        return nil
    }
    
    func createExercise(_ exercise: Exercise) -> Completable {
        return createCompletable { [unowned self] in
            self.exerciseDao.addExercise(exercise: exercise)
        }
    }
    
    func updateExercise(_ exercise: Exercise) -> Completable {
        return createCompletable { [unowned self] in
            self.exerciseDao.updateExercise(exercise: exercise)
        }
    }
    
    func deleteExercide(exerciseId: Int) -> Completable {
        return createCompletable { [unowned self] in
            // TODO: change positions
            self.exerciseDao.deleteExercise(id: exerciseId)
        }
    }
    
    func moveExercise(workoutId: Int, oldPosition: Int, newPosition: Int) -> Completable {
        return createCompletable { [unowned self] in
            if oldPosition != newPosition {
                self.exerciseDao.moveExercise(workoutId: workoutId, oldPosition: oldPosition, newPosition: newPosition)
            }
        }
    }
}
