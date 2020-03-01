//
//  EditWorkoutProtocols.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 26/08/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import Foundation


protocol EditWorkoutViewProtocol: class {
    func setTitle(title: String)
    func setData(name: String, description: String, icon: WorkoutIcon)
    func setSaveButtonEnabled(_ enabled: Bool)
}

protocol EditWorkoutPresenterProtocol: class {
    func onViewDidLoad()
    func onNameChanged(name: String)
    func onDescriptionChanged(description: String)
    func onIconChanged(icon: WorkoutIcon)
    func onIconButtonClick()
    func onCancelButtonClick()
    func onSaveButtonClick()
}

protocol EditWorkoutInteractorProtocol: class {
    func loadWorkout(workoutId: Int)
    func createWorkout(_ workout: Workout)
    func updateWorkout(_ workout: Workout)
}

protocol EditWorkoutInteractorOutputProtocol: class {
    func processWorkout(workout: Workout?)
    func workoutCreated()
    func workoutUpdated()
}

protocol EditWorkoutRouterProtocol: class {
    func hide()
    func openChooseIcon(selectedWorkoutIcon: WorkoutIcon, iconChosenCallback: @escaping (WorkoutIcon) -> Void)
}

