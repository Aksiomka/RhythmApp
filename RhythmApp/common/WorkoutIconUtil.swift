//
//  WorkoutIconUtil.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 01/09/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import UIKit


class WorkoutIconUtil {
    
    static func getUIImageForWorkoutIcon(_ workoutIcon: WorkoutIcon) -> UIImage {
        switch (workoutIcon) {
        case .standing:
            return UIImage.init(named: "workout-icon-1")!
        case .going:
            return UIImage.init(named: "workout-icon-2")!
        case .running:
            return UIImage.init(named: "workout-icon-3")!
        case .waving:
            return UIImage.init(named: "workout-icon-4")!
        case .playingBall:
            return UIImage.init(named: "workout-icon-5")!
        case .moving:
            return UIImage.init(named: "workout-icon-6")!
        case .sitting:
            return UIImage.init(named: "workout-icon-7")!
        case .cycling:
            return UIImage.init(named: "workout-icon-8")!
        }
    }
    
}
