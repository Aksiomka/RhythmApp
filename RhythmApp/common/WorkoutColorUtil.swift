//
//  WorkoutColorUtil.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 20/08/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import UIKit


class WorkoutColorUtil {
    
    static func getUIColorForWorkoutColor(_ workoutColor: WorkoutColor) -> UIColor {
        switch (workoutColor) {
        case .blue:
            return UIColor.init(named: "Blue")!
        case .grey:
            return UIColor.init(named: "Gray")!
        case .red:
            return UIColor.init(named: "Red")!
        case .green:
            return UIColor.init(named: "Green")!
        case .brown:
            return UIColor.init(named: "Brown")!
        case .pink:
            return UIColor.init(named: "Pink")!
        case .orange:
            return UIColor.init(named: "Orange")!
        }
    }
    
}
