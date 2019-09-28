//
//  EditWorkoutPresenter.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 26/08/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import Foundation


class EditWorkoutPresenter: EditWorkoutPresenterProtocol, EditWorkoutInteractorOutputProtocol {
    
    weak var view: EditWorkoutViewProtocol?
    var interactor: EditWorkoutInteractorProtocol!
    var router: EditWorkoutRouterProtocol!
    
    private let workoutId: Int?
    
    private var name: String = ""
    private var description: String = ""
    private var color: WorkoutColor = WorkoutColor.blue
    private var icon: WorkoutIcon = WorkoutIcon.standing
    
    init(workoutId: Int?) {
        self.workoutId = workoutId
    }
    
    func onViewDidLoad() {
        view?.setTitle(title: isEditing() ? "Edit Workout" : "Add Workout")
        loadWorkoutIfNeeded()
        updateData()
    }
    
    func onNameChanged(name: String) {
        self.name = name
        updateSaveButtonEnabledState()
    }
    
    func onDescriptionChanged(description: String) {
        self.description = description
    }
    
    func onColorChanged(color: WorkoutColor) {
        self.color = color
        updateData()
    }
    
    func onIconChanged(icon: WorkoutIcon) {
        self.icon = icon
        updateData()
    }
    
    func onCancelButtonClick() {
        router.hide()
    }
    
    func onSaveButtonClick() {
        if let id = workoutId {
            let workout = Workout()
            workout.id = id
            workout.name = name
            workout.descr = description
            workout.color = color
            workout.icon = icon
            interactor.updateWorkout(workout)
        } else {
            let workout = Workout()
            workout.name = name
            workout.descr = description
            workout.color = color
            workout.icon = icon
            interactor.createWorkout(workout)
        }
    }
    
    func processWorkout(workout: Workout?) {
        if let workout = workout {
            name = workout.name
            description = workout.descr
            color = workout.color
            icon = workout.icon
            updateData()
        }
    }
    
    func workoutCreated() {
        router.hide()
    }
    
    func workoutUpdated() {
        router.hide()
    }
    
    private func loadWorkoutIfNeeded() {
        if let id = workoutId {
            interactor.loadWorkout(workoutId: id)
        }
    }
    
    private func updateData() {
        view?.setData(name: name, description: description, color: color, icon: icon)
        updateSaveButtonEnabledState()
    }
    
    private func isEditing() -> Bool {
        return workoutId != nil
    }
    
    private func updateSaveButtonEnabledState() {
        view?.setSaveButtonEnabled(name != "")
    }
    
}
