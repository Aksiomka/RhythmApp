//
//  ExerciseItem.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 21/10/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import Foundation


struct ExerciseItem {
    var id: Int
    var workoutId: Int
    var name: String
    var position: Int
    var durationInSeconds: Int
    var audio: AudioType
    var isPlaying: Bool
    var isCompleted: Bool
    var remainingSeconds: Int
}
