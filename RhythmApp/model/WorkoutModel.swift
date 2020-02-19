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
    
    private let db: DB
    
    init(db: DB) {
        self.db = db
    }
    
    func getWorkouts() -> Observable<[Workout]> {
        return Observable.create { [unowned self] observer in
            let result = self.db.workoutDao.getWorkouts()
            observer.onNext(result.toArray())
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func getWorkout(workoutId: Int) -> Observable<Workout?> {
        return Observable.create { [unowned self] observer in
            let result = self.db.workoutDao.getWorkoutById(id: workoutId)
            observer.onNext(result)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func createWorkout(_ workout: Workout) -> Completable {
        return Completable.create { [unowned self] completable in
            self.db.workoutDao.addWorkout(workout: workout)
            completable(.completed)
            return Disposables.create()
        }
    }
    
    func updateWorkout(_ workout: Workout) -> Completable {
        return Completable.create { [unowned self] completable in
            self.db.workoutDao.updateWorkout(workout: workout)
            completable(.completed)
            return Disposables.create()
        }
    }
    
    func deleteWorkout(workoutId: Int) -> Completable {
        return Completable.create { [unowned self] completable in
            self.db.workoutDao.deleteWorkout(id: workoutId)
            completable(.completed)
            return Disposables.create()
        }
    }
}
