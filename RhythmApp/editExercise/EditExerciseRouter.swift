//
//  EditExerciseRouter.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 23/09/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import UIKit


class EditExerciseRouter: EditExerciseRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func assembleModule(exerciseId: Int?, workoutId: Int) -> UIViewController {
        let viewController = EditExerciseViewController()
        let presenter = EditExercisePresenter(exerciseId: exerciseId, workoutId: workoutId)
        let interactor = EditExerciseInteractor()
        let router = EditExerciseRouter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        
        router.viewController = viewController
        
        return viewController
    }
    
    func hide() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
}
