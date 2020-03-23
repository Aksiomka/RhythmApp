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


class WorkoutListPresenter: WorkoutListPresenterProtocol, WorkoutListInteractorOutputProtocol, WorkoutAudioPlayerDelegate {
    
    weak var view: WorkoutListViewProtocol?
    var interactor: WorkoutListInteractorProtocol!
    var router: WorkoutListRouterProtocol!
    
    private let workoutsSubject: BehaviorSubject<[WorkoutWithExercises]> = BehaviorSubject<[WorkoutWithExercises]>(value: [])
    
    private let disposeBag = DisposeBag()
    private let audioPlayer: WorkoutAudioPlayer = WorkoutAudioPlayer()
    
    private var openedWorkoutId: Int? = nil
    
    init() {
        audioPlayer.delegate = self
    }
    
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
        let visible = openedWorkoutId != workoutId
        if !visible {
            openedWorkoutId = nil
        } else {
            openedWorkoutId = workoutId
        }
        view?.setExercisesCellVisible(visible: visible, for: workoutId)
    }
    
    func onWorkoutDeleteButtonClick(workoutId: Int) {
        interactor.deleteWorkout(workoutId: workoutId)
    }
    
    func onAddExerciseCellClick(workoutId: Int) {
        router.openCreateNewExercise(workoutId: workoutId)
    }
    
    func onExerciseMoved(workoutId: Int, oldPosition: Int, newPosition: Int) {
        interactor.moveExercise(workoutId: workoutId, oldPosition: oldPosition, newPosition: newPosition)
    }
    
    func onPlayButtonClick(exerciseId: Int, audio: AudioType) {
        if audioPlayer.isPlaying(exerciseId: exerciseId) {
            audioPlayer.pause()
        } else if audioPlayer.isPaused(exerciseId: exerciseId) {
            audioPlayer.resume()
        } else {
            let workouts = try! workoutsSubject.value()
            for workout in workouts {
                if let index = workout.exercises.firstIndex(where: { $0.id == exerciseId }) {
                    let exerciseItemsToPlay = workout.exercises.suffix(from: index).map {
                        ExerciseAudioItem(exerciseId: $0.id, audio: $0.audio, durationInSeconds: $0.durationInSeconds)
                    }
                    audioPlayer.playAudios(exerciseAudioItems: exerciseItemsToPlay)
                    break
                }
            }
        }
        updateData()
    }
    
    func processWorkouts(workouts: [Workout], exercises: [Exercise]) {
        let workoutsWithExercises: [WorkoutWithExercises] = workouts.map { workout in
            let workoutExercises = exercises.filter { $0.workoutId == workout.id }.sorted(by: { $0.position < $1.position })
                .map { exercise in
                    ExerciseItem(id: exercise.id, workoutId: exercise.workoutId, name: exercise.name,
                                 position: exercise.position,
                                 durationInSeconds: exercise.durationInSeconds, audio: exercise.audio,
                                 isPlaying: audioPlayer.isPlaying(exerciseId: exercise.id),
                                 isCompleted: false,
                                 remainingSeconds: audioPlayer.isPlaying(exerciseId: exercise.id) || audioPlayer.isPaused(exerciseId: exercise.id) ? audioPlayer.getRemainingDuration() : exercise.durationInSeconds)
                }
            let totalDurationInSeconds = workoutExercises.reduce(0, { $0 + $1.durationInSeconds })
            return WorkoutWithExercises(workout: workout, exercises: workoutExercises, totalDurationInSeconds: totalDurationInSeconds)
        }
        workoutsSubject.onNext(workoutsWithExercises)
    }
    
    func exerciseStarted(exerciseId: Int, currentTimeInSeconds: TimeInterval, durationInSeconds: TimeInterval) {
        updateData()
        view?.exerciseStarted(exerciseId: exerciseId, currentTimeInSeconds: currentTimeInSeconds, durationInSeconds: durationInSeconds)
    }
    
    func exercisePaused(exerciseId: Int, currentTimeInSeconds: TimeInterval, durationInSeconds: TimeInterval) {
        view?.exercisePaused(exerciseId: exerciseId, currentTimeInSeconds: currentTimeInSeconds, durationInSeconds: durationInSeconds)
    }
    
    func exerciseCompleted(exerciseId: Int) {
        updateData()
        view?.exerciseStopped(exerciseId: exerciseId)
    }
    
    func remainingDurationChanged(exerciseId: Int) {
        updateData()
    }
    
    private func updateData() {
        interactor.loadWorkouts()
    }
    
}
