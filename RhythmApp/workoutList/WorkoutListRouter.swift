//
//  WorkoutListRouter.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 17/08/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import UIKit


class WorkoutListRouter: WorkoutListRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController {
        let viewController = WorkoutListViewController()
        let presenter = WorkoutListPresenter()
        let interactor = WorkoutListInteractor()
        let router = WorkoutListRouter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        router.viewController = viewController
        
        return viewController
    }
    
    func openCreateNewWorkout() {
        let createWorkoutViewController = EditWorkoutRouter.assembleModule(workoutId: nil)
        viewController?.navigationController?.pushViewController(createWorkoutViewController, animated: true)
    }
    
    func openWorkout(workoutId: Int) {
        let editWorkoutViewController = EditWorkoutRouter.assembleModule(workoutId: workoutId)
        viewController?.navigationController?.pushViewController(editWorkoutViewController, animated: true)
    }
    
    func openCreateNewExercise(workoutId: Int) {
        let createExerciseViewController = EditExerciseRouter.assembleModule(exerciseId: nil, workoutId: workoutId)
        viewController?.navigationController?.pushViewController(createExerciseViewController, animated: true)
    }
    
}
