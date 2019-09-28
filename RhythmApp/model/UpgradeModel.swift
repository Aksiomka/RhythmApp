//
//  UpgradeModel.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 17/08/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import Foundation


class UpgradeModel {
    
    static func processFirstLaunch() {
        let demoWorkout = Workout()
        demoWorkout.name = "Push ups"
        demoWorkout.descr = "This is demo workout"
        demoWorkout.color = .blue
        demoWorkout.icon = .moving
        DB.sharedInstance.workoutDao.addWorkout(workout: demoWorkout)
    }
    
}
