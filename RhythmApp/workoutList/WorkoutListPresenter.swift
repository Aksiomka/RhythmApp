//
//  WorkoutListPresenter.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 17/08/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


class WorkoutListPresenter: WorkoutListPresenterProtocol, WorkoutListInteractorOutputProtocol {
    
    weak var view: WorkoutListViewProtocol?
    var interactor: WorkoutListInteractorProtocol!
    var router: WorkoutListRouterProtocol!
    
    private let workoutsSubject: PublishSubject<[WorkoutWithExercises]> = PublishSubject<[WorkoutWithExercises]>()
    
    private let disposeBag = DisposeBag()
    
    func onViewDidLoad() {
        view?.setWorkoutsDriver(workoutsDriver: workoutsSubject.asDriver(onErrorJustReturn: []))
        updateData()
    }
    
    func onNewWorkoutButtonClick() {
        router.openCreateNewWorkout()
    }
    
    func onEditWorkoutButtonClick(workoutId: Int) {
        router.openWorkout(workoutId: workoutId)
    }
    
    func onWorkoutSelected(workoutId: Int) {
        
    }
    
    func onWorkoutDeleteButtonClick(workoutId: Int) {
        interactor.deleteWorkout(workoutId: workoutId)
    }
    
    func onAddExerciseCellClick(workoutId: Int) {
        router.openCreateNewExercise(workoutId: workoutId)
    }
    
    func onExerciseMoved(workoutId: Int, oldPosition: Int, newPosition: Int) {
        
    }
    
    func processWorkouts(workouts: [Workout], exercises: [Exercise]) {
        let workoutsWithExercises: [WorkoutWithExercises] = workouts.map { workout in
            let workoutExercises = exercises.filter { $0.workoutId == workout.id }
            return WorkoutWithExercises(workout: workout, exercises: workoutExercises)
        }
        workoutsSubject.onNext(workoutsWithExercises)
    }
    
    func workoutDeleted() {
        updateData()
    }
    
    private func updateData() {
        interactor.loadWorkouts()
    }
    
}
