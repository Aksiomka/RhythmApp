//
//  AudioType.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 07/10/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import Foundation


@objc enum AudioType: NSInteger {
    case one
    case two
    case three
    case four
    case five
    
    static let allValues: [AudioType] = [.one, .two, .three, .four, .four]
}
