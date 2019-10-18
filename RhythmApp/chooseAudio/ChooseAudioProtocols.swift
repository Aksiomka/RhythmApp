//
//  ChooseAudioProtocols.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 18/10/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


protocol ChooseAudioViewProtocol: class {
    func setAudioItemsDriver(audiosDriver: Driver<[AudioItem]>)
}

protocol ChooseAudioPresenterProtocol: class {
    func onViewDidLoad()
    func onChooseButtonClick()
    func onCancelButtonClick()
    func onAudioItemSelected(audioType: AudioType)
}

protocol ChooseAudioRouterProtocol: class {
    func hide()
}

