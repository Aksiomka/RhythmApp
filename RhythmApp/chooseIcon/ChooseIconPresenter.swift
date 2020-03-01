//
//  ChooseIconPresenter.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 01/03/2020.
//  Copyright © 2020 Svetlana Gladysheva. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


class ChooseIconPresenter: ChooseIconPresenterProtocol {

    weak var view: ChooseIconViewProtocol?
    var router: ChooseIconRouterProtocol!
    
    private var selectedWorkoutIcon: WorkoutIcon
    private let iconChosenCallback: (WorkoutIcon) -> Void
    
    private let iconItemsSubject: PublishSubject<[WorkoutIconItem]> = PublishSubject<[WorkoutIconItem]>()

    init(selectedWorkoutIcon: WorkoutIcon, iconChosenCallback: @escaping (WorkoutIcon) -> Void) {
        self.selectedWorkoutIcon = selectedWorkoutIcon
        self.iconChosenCallback = iconChosenCallback
    }
    
    func onViewDidLoad() {
        view?.setIconsDriver(iconItemsDriver: iconItemsSubject.asDriver(onErrorJustReturn: []))
        updateData()
    }
    
    func onIconSelected(icon: WorkoutIcon) {
        selectedWorkoutIcon = icon
        updateData()
        iconChosenCallback(icon)
        router.hide()
    }
    
    private func updateData() {
        let workoutIconItems = WorkoutIcon.allCases.map { [unowned self] workoutIcon in
            return self.convertToIconItem(workoutIcon: workoutIcon)
        }
        iconItemsSubject.onNext(workoutIconItems)
    }
    
    private func convertToIconItem(workoutIcon: WorkoutIcon) -> WorkoutIconItem {
        return WorkoutIconItem(workoutIcon: workoutIcon, selected: selectedWorkoutIcon == workoutIcon)
    }
    
}
