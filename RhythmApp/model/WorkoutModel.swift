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


class WorkoutModel: BaseModel {
    
    private let workoutDao = WorkoutDao()
    
    func getWorkouts() -> Observable<[Workout]> {
        let result = workoutDao.getWorkouts()
        return Observable.array(from: result)
    }
    
    func getWorkout(workoutId: Int) -> Observable<Workout>? {
        if let workout = workoutDao.getWorkoutById(id: workoutId) {
            return Observable.from(object: workout)
        }
        return nil
    }
    
    func createWorkout(_ workout: Workout) -> Completable {
        return createCompletable { [unowned self] in
            self.workoutDao.addWorkout(workout: workout)
        }
    }
    
    func updateWorkout(_ workout: Workout) -> Completable {
        return createCompletable { [unowned self] in
            self.workoutDao.updateWorkout(workout: workout)
        }
    }
    
    func deleteWorkout(workoutId: Int) -> Completable {
        return createCompletable { [unowned self] in
            self.workoutDao.deleteWorkout(id: workoutId)
        }
    }
}
