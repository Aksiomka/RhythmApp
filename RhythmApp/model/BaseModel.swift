//
//  BaseModel.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 20/02/2020.
//  Copyright © 2020 Svetlana Gladysheva. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class BaseModel {

    internal let db: DB

    init(db: DB) {
        self.db = db
    }
    
    internal func createCompletable(action: @escaping () -> Void) -> Completable {
        return Completable.create { completable in
            action()
            completable(.completed)
            return Disposables.create()
        }
    }

}
