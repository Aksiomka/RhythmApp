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
    
    private let db: DB
    
    init(db: DB) {
        self.db = db
    }
    
    func getExercises() -> Observable<[Exercise]> {
        return Observable.create { [unowned self] observer in
            let result = self.db.exerciseDao.getExercises()
            observer.onNext(result.toArray())
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func getExercisesByWorkoutId(_ workoutId: Int) -> Observable<[Exercise]> {
        return Observable.create { [unowned self] observer in
            let result = self.db.exerciseDao.getExercisesByWorkoutId(workoutId)
            observer.onNext(result.toArray())
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func getExercise(exerciseId: Int) -> Observable<Exercise?> {
        return Observable.create { [unowned self] observer in
            let result = self.db.exerciseDao.getExerciseById(id: exerciseId)
            observer.onNext(result)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func createExercise(_ exercise: Exercise) -> Completable {
        return Completable.create { [unowned self] completable in
            self.db.exerciseDao.addExercise(exercise: exercise)
            completable(.completed)
            return Disposables.create()
        }
    }
    
    func updateExercise(_ exercise: Exercise) -> Completable {
        return Completable.create { [unowned self] completable in
            self.db.exerciseDao.updateExercise(exercise: exercise)
            completable(.completed)
            return Disposables.create()
        }
    }
    
    func deleteExercide(exerciseId: Int) -> Completable {
        return Completable.create { [unowned self] completable in
            // TODO: change positions
            self.db.exerciseDao.deleteExercise(id: exerciseId)
            completable(.completed)
            return Disposables.create()
        }
    }
    
    func moveExercise(workoutId: Int, oldPosition: Int, newPosition: Int) -> Completable {
        return Completable.create { [unowned self] completable in
            if oldPosition != newPosition {
                self.db.exerciseDao.moveExercise(workoutId: workoutId, oldPosition: oldPosition, newPosition: newPosition)
            }
            completable(.completed)
            return Disposables.create()
        }
    }
}
