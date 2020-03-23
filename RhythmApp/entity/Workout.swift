//
//  Workout.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 17/08/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import Foundation
import RealmSwift


class Workout: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var descr = ""
    @objc dynamic var color: WorkoutColor = WorkoutColor.brown
    @objc dynamic var icon: WorkoutIcon = WorkoutIcon.standing
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
