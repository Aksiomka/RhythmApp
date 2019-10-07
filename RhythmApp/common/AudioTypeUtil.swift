//
//  AudioTypeUtil.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 07/10/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import Foundation


class AudioTypeUtil {
    
    static func getFileNameForAudioType(_ audioType: AudioType) -> String {
        switch (audioType) {
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        }
    }
    
}
