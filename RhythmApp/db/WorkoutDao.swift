//
//  WorkoutResource.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 17/08/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import Foundation
import RealmSwift


class WorkoutDao {
    
    func getWorkouts() -> Results<Workout> {
        let realm = getRealm()
        return realm.objects(Workout.self).sorted(byKeyPath: "id", ascending: true)
    }
    
    func getWorkoutById(id: Int) -> Workout? {
        let realm = getRealm()
        let result = realm.objects(Workout.self).filter("id == %d", id)
        return result.first
    }
    
    func addWorkout(workout: Workout) {
        let realm = getRealm()
        try! realm.write {
            let maxId = realm.objects(Workout.self).max(ofProperty: "id") as Int? ?? 0
            workout.id = maxId + 1
            realm.add(workout, update: .modified)
        }
    }
    
    func updateWorkout(workout: Workout) {
        let realm = getRealm()
        try! realm.write {
            realm.add(workout, update: .modified)
        }
    }
    
    func deleteWorkout(id: Int) {
        let realm = getRealm()
        try! realm.write {
            realm.delete(realm.objects(Workout.self).filter("id == %d", id))
        }
    }
    
    func getRealm() -> Realm {
        return try! Realm()
    }
}
