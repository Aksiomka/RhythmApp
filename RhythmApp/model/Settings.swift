//
//  Settings.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 17/08/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import Foundation


class Settings {
    
    private static let APP_ALREADY_LAUNCHED_KEY = "app_already_launched"
    
    static var appAlreadyLaunched: Bool {
        get {
            return UserDefaults.standard.bool(forKey: APP_ALREADY_LAUNCHED_KEY)
        }
        set(launched) {
            UserDefaults.standard.set(launched, forKey: APP_ALREADY_LAUNCHED_KEY)
        }
    }
    
}
