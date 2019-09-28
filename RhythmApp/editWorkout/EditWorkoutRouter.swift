//
//  EditWorkoutRouter.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 26/08/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import UIKit


class EditWorkoutRouter: EditWorkoutRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func assembleModule(workoutId: Int?) -> UIViewController {
        let viewController = EditWorkoutViewController()
        let presenter = EditWorkoutPresenter(workoutId: workoutId)
        let interactor = EditWorkoutInteractor()
        let router = EditWorkoutRouter()
        
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
