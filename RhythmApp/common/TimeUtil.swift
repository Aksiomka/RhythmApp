//
//  TimeUtil.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 20/03/2020.
//  Copyright © 2020 Svetlana Gladysheva. All rights reserved.
//

import Foundation


class TimeUtil {
    
    static func formatSeconds(seconds: Int) -> String {
        let min = seconds / 60
        let sec = seconds % 60
        let formattedSec = sec < 10 ? "0\(sec)" : "\(sec)"
        return "\(min):\(formattedSec)"
    }
    
}
