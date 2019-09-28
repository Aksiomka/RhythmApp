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
}

protocol WorkoutListPresenterProtocol: class {
    func onViewDidLoad()
    func onNewWorkoutButtonClick()
    func onWorkoutSelected(workoutId: Int)
    func onWorkoutDeleteButtonClick(workoutId: Int)
}

protocol WorkoutListInteractorProtocol: class {
    func loadWorkouts()
    func deleteWorkout(workoutId: Int)
}

protocol WorkoutListInteractorOutputProtocol: class {
    func processWorkouts(workouts: [Workout], exercises: [Exercise])
    func workoutDeleted()
}

protocol WorkoutListRouterProtocol: class {
    func openCreateNewWorkout()
    func openWorkout(workoutId: Int)
}

