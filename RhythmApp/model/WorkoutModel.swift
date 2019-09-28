//
//  WorkoutModel.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 17/08/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import Foundation
import RealmSwift
import RxCocoa
import RxSwift
import RxRealm


class WorkoutModel {
    
    static func getWorkouts() -> Observable<[Workout]> {
        let res = DB.sharedInstance.workoutDao.getWorkouts()
        return Observable.array(from: res)
    }
    
    static func getWorkout(workoutId: Int) -> Observable<Workout?> {
        let res = DB.sharedInstance.workoutDao.getWorkoutById(id: workoutId)
        return Observable.just(res)
    }
    
    static func createWorkout(_ workout: Workout) -> Completable {
        DB.sharedInstance.workoutDao.addWorkout(workout: workout)
        return Completable.empty()
    }
    
    static func updateWorkout(_ workout: Workout) -> Completable {
        DB.sharedInstance.workoutDao.updateWorkout(workout: workout)
        return Completable.empty()
    }
    
    static func deleteWorkout(workoutId: Int) -> Completable {
        DB.sharedInstance.workoutDao.deleteWorkout(id: workoutId)
        return Completable.empty()
    }
}
