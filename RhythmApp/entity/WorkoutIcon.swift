//
//  WorkoutIcon.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 01/09/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import Foundation


@objc enum WorkoutIcon: NSInteger {
    case standing
    case going
    case running
    case waving
    case playingBall
    case moving
    case sitting
    case cycling
    
    static let allValues: [WorkoutIcon] = [.standing, .going, .running, .waving, .playingBall, .moving, .sitting, .cycling]
}
