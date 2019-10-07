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
    func playAudio(audioType: AudioType)
    func pauseAudio()
    func resumeAudio()
}

protocol WorkoutListPresenterProtocol: class {
    func onViewDidLoad()
    func onNewWorkoutButtonClick()
    func onEditWorkoutButtonClick(workoutId: Int)
    func onWorkoutSelected(workoutId: Int)
    func onWorkoutDeleteButtonClick(workoutId: Int)
    func onAddExerciseCellClick(workoutId: Int)
    func onExerciseMoved(workoutId: Int, oldPosition: Int, newPosition: Int)
    func onPlayButtonClick(exerciseId: Int, audioType: AudioType)
}

protocol WorkoutListInteractorProtocol: class {
    func loadWorkouts()
    func deleteWorkout(workoutId: Int)
    func moveExercise(workoutId: Int, oldPosition: Int, newPosition: Int)
}

protocol WorkoutListInteractorOutputProtocol: class {
    func processWorkouts(workouts: [Workout], exercises: [Exercise])
    func workoutDeleted()
    func exerciseMoved()
}

protocol WorkoutListRouterProtocol: class {
    func openCreateNewWorkout()
    func openWorkout(workoutId: Int)
    func openCreateNewExercise(workoutId: Int)
}

