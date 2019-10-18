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


class ExerciseModel {
    
    static func getExercises() -> Observable<[Exercise]> {
        let res = DB.sharedInstance.exerciseDao.getExercises()
        return Observable.array(from: res)
    }
    
    static func getExercisesByWorkoutId(_ workoutId: Int) -> Observable<[Exercise]> {
        let res = DB.sharedInstance.exerciseDao.getExercisesByWorkoutId(workoutId)
        return Observable.array(from: res)
    }
    
    static func getExercise(exerciseId: Int) -> Observable<Exercise?> {
        let res = DB.sharedInstance.exerciseDao.getExerciseById(id: exerciseId)
        return Observable.just(res)
    }
    
    static func createExercise(_ exercise: Exercise) -> Completable {
        DB.sharedInstance.exerciseDao.addExercise(exercise: exercise)
        return Completable.empty()
    }
    
    static func updateExercise(_ exercise: Exercise) -> Completable {
        DB.sharedInstance.exerciseDao.updateExercise(exercise: exercise)
        return Completable.empty()
    }
    
    static func deleteExercide(exerciseId: Int) -> Completable {
        // todo change positions
        DB.sharedInstance.exerciseDao.deleteExercise(id: exerciseId)
        return Completable.empty()
    }
    
    static func moveExercise(workoutId: Int, oldPosition: Int, newPosition: Int) -> Completable {
        if oldPosition != newPosition {
            DB.sharedInstance.exerciseDao.moveExercise(workoutId: workoutId, oldPosition: oldPosition, newPosition: newPosition)
        }
        return Completable.empty()
    }
}
