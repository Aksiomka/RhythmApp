//
//  Exercise.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 23/09/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import Foundation
import RealmSwift


class Exercise: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var workoutId = 0
    @objc dynamic var name = ""
    @objc dynamic var position = 0
    @objc dynamic var durationInSeconds = 0
    @objc dynamic var audio: AudioType = AudioType.one
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
