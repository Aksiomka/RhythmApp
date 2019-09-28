//
//  WorkoutColor.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 18/08/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import Foundation


@objc enum WorkoutColor: NSInteger {
    case grey
    case blue
    case red
    case green
    case brown
    case pink
    case orange
    
    static let allValues: [WorkoutColor] = [.grey, .blue, .red, .green, .brown, .pink, .orange]
}
