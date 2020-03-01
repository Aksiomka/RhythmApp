//
//  ChooseIconRouter.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 01/03/2020.
//  Copyright © 2020 Svetlana Gladysheva. All rights reserved.
//

import UIKit


class ChooseIconRouter: ChooseIconRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func assembleModule(selectedWorkoutIcon: WorkoutIcon, iconChosenCallback: @escaping (WorkoutIcon) -> Void) -> UIViewController {
        let viewController = ChooseIconViewController()
        let presenter = ChooseIconPresenter(selectedWorkoutIcon: selectedWorkoutIcon, iconChosenCallback: iconChosenCallback)
        let router = ChooseIconRouter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.router = router
        
        router.viewController = viewController
        
        return viewController
    }
    
    func hide() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
}
