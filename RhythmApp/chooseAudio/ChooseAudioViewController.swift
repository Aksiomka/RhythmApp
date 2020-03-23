//
//  ChooseAudioViewController.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 18/10/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources


class ChooseAudioViewController: UIViewController, ChooseAudioViewProtocol, UITableViewDelegate {
    
    var presenter: ChooseAudioPresenterProtocol!
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var chooseButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewDidLoad()
        
        tableView.register(UINib(nibName: "AudioCell", bundle: nil), forCellReuseIdentifier: "AudioCell")
    }
    
    func setAudioItemsDriver(audiosDriver: Driver<[AudioItem]>) {
        let dataSource = RxTableViewSectionedReloadDataSource<AudioSectionModel>(configureCell: { (dataSource, table, idxPath, _) in
            let audioItem = dataSource[idxPath]
            let audioCell: AudioCell = table.dequeueReusableCell(withIdentifier: "AudioCell", for: idxPath) as! AudioCell
            audioCell.setData(name: audioItem.name, isPlaying: audioItem.isPlaying, selected: audioItem.selected)
            audioCell.playButtonClickCallback = { [unowned self] in
                self.presenter.onPlayButtonClick(audioType: audioItem.audioType)
            }
            return audioCell
        })
        
        audiosDriver
            .map { audioItems in
                return [AudioSectionModel(items: audioItems)]
            }
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .map { indexPath in
                return (indexPath, dataSource[indexPath])
            }
            .subscribe(onNext: { [weak self] pair in
                self?.presenter.onAudioItemSelected(audioType: pair.1.audioType)
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func onChooseButtonClick(_ sender: UIButton) {
        presenter.onChooseButtonClick()
    }
    
    @IBAction func onCancelButtonClick(_ sender: UIButton) {
        presenter.onCancelButtonClick()
    }
    
}


class AudioSectionModel: SectionModelType {
    typealias Item = AudioItem
    
    var items: [AudioItem]
    
    required init(original: AudioSectionModel, items: [AudioItem]) {
        self.items = items
    }
    
    init(items: [AudioItem]) {
        self.items = items
    }
}
