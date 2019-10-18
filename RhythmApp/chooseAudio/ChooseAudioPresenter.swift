//
//  ChooseAudioPresenter.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 18/10/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


class ChooseAudioPresenter: ChooseAudioPresenterProtocol {

    weak var view: ChooseAudioViewProtocol?
    var router: ChooseAudioRouterProtocol!
    
    private var selectedAudioType: AudioType
    private let audioChosenCallback: (AudioType) -> Void
    
    private let audioItemsSubject: PublishSubject<[AudioItem]> = PublishSubject<[AudioItem]>()

    init(selectedAudioType: AudioType, audioChosenCallback: @escaping (AudioType) -> Void) {
        self.selectedAudioType = selectedAudioType
        self.audioChosenCallback = audioChosenCallback
    }
    
    func onViewDidLoad() {
        view?.setAudioItemsDriver(audiosDriver: audioItemsSubject.asDriver(onErrorJustReturn: []))
        updateData()
    }
    
    func onChooseButtonClick() {
        audioChosenCallback(selectedAudioType)
        router.hide()
    }
    
    func onCancelButtonClick() {
        router.hide()
    }
    
    func onAudioItemSelected(audioType: AudioType) {
        selectedAudioType = audioType
        updateData()
    }
    
    private func updateData() {
        let audioItems = AudioType.allValues.map { [unowned self] audioType in
            return self.convertToAudioItem(audioType: audioType)
        }
        audioItemsSubject.onNext(audioItems)
    }
    
    private func convertToAudioItem(audioType: AudioType) -> AudioItem {
        return AudioItem(audioType: audioType,
                         name: AudioTypeUtil.getFileNameForAudioType(audioType),
                         isPlaying: false,
                         selected: selectedAudioType == audioType)
    }
    
}
