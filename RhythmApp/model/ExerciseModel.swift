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
            let exercises = DB.sharedInstance.exerciseDao.getExercisesByWorkoutId(workoutId)
            
            if oldPosition < newPosition {
                let changedExercises = exercises.filter { $0.position > oldPosition && $0.position <= newPosition}
                for exercise in changedExercises {
                    exercise.position = exercise.position - 1
                    DB.sharedInstance.exerciseDao.updateExercise(exercise: exercise)
                }
            } else {
                let changedExercises = exercises.filter { $0.position >= newPosition && $0.position < newPosition}
                for exercise in changedExercises {
                    exercise.position = exercise.position + 1
                    DB.sharedInstance.exerciseDao.updateExercise(exercise: exercise)
                }
            }
            
            if let movedExercise = exercises.first(where: { $0.position == oldPosition }) {
                movedExercise.position = newPosition
                DB.sharedInstance.exerciseDao.updateExercise(exercise: movedExercise)
            }
        }
        return Completable.empty()
    }
}
