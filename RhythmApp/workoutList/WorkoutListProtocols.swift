//
//  WorkoutListProtocols.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 17/08/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


protocol WorkoutListViewProtocol: class {
    func setWorkoutsDriver(workoutsDriver: Driver<[WorkoutWithExercises]>)
    func setExercisesCellVisible(visible: Bool, for workoutId: Int)
    func exerciseStarted(exerciseId: Int, currentTimeInSeconds: TimeInterval, durationInSeconds: TimeInterval)
    func exercisePaused(exerciseId: Int, currentTimeInSeconds: TimeInterval, durationInSeconds: TimeInterval)
    func exerciseStopped(exerciseId: Int)
}

protocol WorkoutListPresenterProtocol: class {
    func onViewDidLoad()
    func onNewWorkoutButtonClick()
    func onEditWorkoutButtonClick(workoutId: Int)
    func onWorkoutSelected(workoutId: Int)
    func onWorkoutDeleteButtonClick(workoutId: Int)
    func onAddExerciseCellClick(workoutId: Int)
    func onExerciseMoved(workoutId: Int, oldPosition: Int, newPosition: Int)
    func onPlayButtonClick(exerciseId: Int, audio: AudioType)
}

protocol WorkoutListInteractorProtocol: class {
    func loadWorkouts()
    func deleteWorkout(workoutId: Int)
    func moveExercise(workoutId: Int, oldPosition: Int, newPosition: Int)
}

protocol WorkoutListInteractorOutputProtocol: class {
    func processWorkouts(workouts: [Workout], exercises: [Exercise])
}

protocol WorkoutListRouterProtocol: class {
    func openCreateNewWorkout()
    func openWorkout(workoutId: Int)
    func openCreateNewExercise(workoutId: Int)
}

