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
    
    func getExercises() -> Observable<[Exercise]> {
        let result = db.exerciseDao.getExercises()
        return Observable.array(from: result)
    }
    
    func getExercisesByWorkoutId(_ workoutId: Int) -> Observable<[Exercise]> {
        let result = db.exerciseDao.getExercisesByWorkoutId(workoutId)
        return Observable.array(from: result)
    }
    
    func getExercise(exerciseId: Int) -> Observable<Exercise>? {
        if let exercise = db.exerciseDao.getExerciseById(id: exerciseId) {
            return Observable.from(object: exercise)
        }
        return nil
    }
    
    func createExercise(_ exercise: Exercise) -> Completable {
        return createCompletable { [unowned self] in
            self.db.exerciseDao.addExercise(exercise: exercise)
        }
    }
    
    func updateExercise(_ exercise: Exercise) -> Completable {
        return createCompletable { [unowned self] in
            self.db.exerciseDao.updateExercise(exercise: exercise)
        }
    }
    
    func deleteExercide(exerciseId: Int) -> Completable {
        return createCompletable { [unowned self] in
            // TODO: change positions
            self.db.exerciseDao.deleteExercise(id: exerciseId)
        }
    }
    
    func moveExercise(workoutId: Int, oldPosition: Int, newPosition: Int) -> Completable {
        return createCompletable { [unowned self] in
            if oldPosition != newPosition {
                self.db.exerciseDao.moveExercise(workoutId: workoutId, oldPosition: oldPosition, newPosition: newPosition)
            }
        }
    }
}
