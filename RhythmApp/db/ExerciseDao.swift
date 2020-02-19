//
//  ExerciseDao.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 23/09/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import Foundation
import RealmSwift


class ExerciseDao {
    
    func getExercises() -> Results<Exercise> {
        let realm = getRealm()
        return realm.objects(Exercise.self)
    }
    
    func getExercisesByWorkoutId(_ id: Int) -> Results<Exercise> {
        let realm = getRealm()
        return realm.objects(Exercise.self).filter("workoutId == %d", id)
    }
    
    func getExerciseById(id: Int) -> Exercise? {
        let realm = getRealm()
        let result = realm.objects(Exercise.self).filter("id == %d", id)
        return result.first
    }
    
    func addExercise(exercise: Exercise) {
        let realm = getRealm()
        try! realm.write {
            let maxId = realm.objects(Exercise.self).max(ofProperty: "id") as Int? ?? 0
            exercise.id = maxId + 1
            let maxPosition = realm.objects(Exercise.self).filter("workoutId == %d", exercise.workoutId).max(ofProperty: "position") as Int? ?? -1
            exercise.position = maxPosition + 1
            realm.add(exercise, update: .error)
        }
    }
    
    func updateExercise(exercise: Exercise) {
        let realm = getRealm()
        try! realm.write {
            realm.add(exercise, update: .modified)
        }
    }
    
    func moveExercise(workoutId: Int, oldPosition: Int, newPosition: Int) {
        let realm = getRealm()
        let exercisesResults = realm.objects(Exercise.self).filter("workoutId == %d", workoutId)
        let exercises = exercisesResults.toArray()
        
        realm.beginWrite()
        
        var exercisesToUpdate: [Exercise] = []

        let movedExercise = exercises.first(where: { $0.position == oldPosition })
        
        if oldPosition < newPosition {
            let changedExercises = exercises.filter { $0.position > oldPosition && $0.position <= newPosition}
            for exercise in changedExercises {
                exercise.position = exercise.position - 1
                exercisesToUpdate.append(exercise)
            }
        } else {
            let changedExercises = exercises.filter { $0.position >= newPosition && $0.position < oldPosition}
            for exercise in changedExercises {
                exercise.position = exercise.position + 1
                exercisesToUpdate.append(exercise)
            }
        }
        
        if let movedExercise = movedExercise {
            movedExercise.position = newPosition
            exercisesToUpdate.append(movedExercise)
        }
        
        for exercise in exercisesToUpdate {
            realm.add(exercise, update: .modified)
        }
        
        try! realm.commitWrite()
    }
    
    func deleteExercise(id: Int) {
        let realm = getRealm()
        try! realm.write {
            realm.delete(realm.objects(Exercise.self).filter("id == %d", id))
        }
    }
    
    func getRealm() -> Realm {
        return try! Realm()
    }
}
