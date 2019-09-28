//
//  EditExercisePresenter.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 23/09/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import Foundation


class EditExercisePresenter: EditExercisePresenterProtocol, EditExerciseInteractorOutputProtocol {
    
    weak var view: EditExerciseViewProtocol?
    var interactor: EditExerciseInteractorProtocol!
    var router: EditExerciseRouterProtocol!
    
    private let exerciseId: Int?
    private let workoutId: Int
    
    private var name: String = ""
    private var durationMinutes: Int = 0
    private var durationSeconds: Int = 0
    
    init(exerciseId: Int?, workoutId: Int) {
        self.exerciseId = exerciseId
        self.workoutId = workoutId
    }
    
    func onViewDidLoad() {
        view?.setTitle(title: isEditing() ? "Edit Exercise" : "Add Exercise")
        view?.setPickersData(minutesData: Array((0...30)), secondsData: Array(stride(from: 0, through: 55, by: 5)))
        loadExercise()
    }
    
    func onNameChanged(name: String) {
        self.name = name
        updateSaveButtonEnabledState()
    }
    
    func onDurationMinutesChanged(minutes: Int) {
        self.durationMinutes = minutes
    }
    
    func onDurationSecondsChanged(seconds: Int) {
        self.durationSeconds = seconds
    }
    
    func onCancelButtonClick() {
        router.hide()
    }
    
    func onSaveButtonClick() {
        if let id = exerciseId {
            let exercise = Exercise()
            exercise.id = id
            exercise.name = name
            exercise.durationInSeconds = durationMinutes * 60 + durationSeconds
            exercise.workoutId = workoutId
            interactor.updateExercise(exercise)
        } else {
            let exercise = Exercise()
            exercise.name = name
            exercise.durationInSeconds = durationMinutes * 60 + durationSeconds
            exercise.workoutId = workoutId
            interactor.createExercise(exercise)
        }
    }
    
    func processExercise(exercise: Exercise?, workout: Workout?) {
        if let exercise = exercise {
            name = exercise.name
            updateData()
        }
        if let workout = workout {
            view?.setWorkoutColor(workout.color)
        }
    }
    
    func exerciseCreated() {
        router.hide()
    }
    
    func exerciseUpdated() {
        router.hide()
    }
    
    private func loadExercise() {
        interactor.loadExercise(exerciseId: exerciseId, workoutId: workoutId)
    }
    
    private func updateData() {
        view?.setData(name: name)
        updateSaveButtonEnabledState()
    }
    
    private func isEditing() -> Bool {
        return exerciseId != nil
    }
    
    private func updateSaveButtonEnabledState() {
        view?.setSaveButtonEnabled(name != "")
    }
    
}
