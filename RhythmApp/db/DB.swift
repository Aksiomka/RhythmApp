//
//  DB.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 17/08/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import Foundation
import RealmSwift


class DB {
    
    var workoutDao: WorkoutDao
    var exerciseDao: ExerciseDao
    
    static let sharedInstance = DB()
    
    private init() {
        workoutDao = WorkoutDao()
        exerciseDao = ExerciseDao()
    }
    
}
