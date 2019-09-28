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
        return realm.objects(Exercise.self).filter("wirkoutId == %d", id)
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
            let maxPosition = realm.objects(Exercise.self).max(ofProperty: "position") as Int? ?? 0
            exercise.position = maxPosition + 1
            realm.add(exercise, update: false)
        }
    }
    
    func updateExercise(exercise: Exercise) {
        let realm = getRealm()
        try! realm.write {
            realm.add(exercise, update: true)
        }
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
