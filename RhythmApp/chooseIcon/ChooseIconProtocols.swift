//
//  ChooseIconProtocols.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 01/03/2020.
//  Copyright © 2020 Svetlana Gladysheva. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


protocol ChooseIconViewProtocol: class {
    func setIconsDriver(iconItemsDriver: Driver<[WorkoutIconItem]>)
}

protocol ChooseIconPresenterProtocol: class {
    func onViewDidLoad()
    func onIconSelected(icon: WorkoutIcon)
}

protocol ChooseIconRouterProtocol: class {
    func hide()
}

