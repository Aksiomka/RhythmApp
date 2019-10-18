//
//  ChooseAudioRouter.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 18/10/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import UIKit


class ChooseAudioRouter: ChooseAudioRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func assembleModule(selectedAudioType: AudioType, audioChosenCallback: @escaping (AudioType) -> Void) -> UIViewController {
        let viewController = ChooseAudioViewController()
        let presenter = ChooseAudioPresenter(selectedAudioType: selectedAudioType, audioChosenCallback: audioChosenCallback)
        let router = ChooseAudioRouter()
        
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
