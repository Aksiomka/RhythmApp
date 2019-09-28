//
//  EditExerciseProtocols.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 23/09/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import Foundation


protocol EditExerciseViewProtocol: class {
    func setTitle(title: String)
    func setPickersData(minutesData: [Int], secondsData: [Int])
    func setData(name: String)
    func setWorkoutColor(_ workoutColor: WorkoutColor)
    func setSaveButtonEnabled(_ enabled: Bool)
}

protocol EditExercisePresenterProtocol: class {
    func onViewDidLoad()
    func onNameChanged(name: String)
    func onDurationMinutesChanged(minutes: Int)
    func onDurationSecondsChanged(seconds: Int)
    func onCancelButtonClick()
    func onSaveButtonClick()
}

protocol EditExerciseInteractorProtocol: class {
    func loadExercise(exerciseId: Int?, workoutId: Int)
    func createExercise(_ exercise: Exercise)
    func updateExercise(_ exercise: Exercise)
}

protocol EditExerciseInteractorOutputProtocol: class {
    func processExercise(exercise: Exercise?, workout: Workout?)
    func exerciseCreated()
    func exerciseUpdated()
}

protocol EditExerciseRouterProtocol: class {
    func hide()
}

