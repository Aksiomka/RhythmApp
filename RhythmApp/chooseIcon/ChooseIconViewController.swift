//
//  ChooseIconViewController.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 01/03/2020.
//  Copyright © 2020 Svetlana Gladysheva. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources


class ChooseIconViewController: UIViewController, ChooseIconViewProtocol, UITableViewDelegate {
    
    var presenter: ChooseIconPresenterProtocol!
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewDidLoad()
        
        tableView.register(UINib(nibName: "WorkoutIconCell", bundle: nil), forCellReuseIdentifier: "WorkoutIconCell")
    }
    
    func setIconsDriver(iconItemsDriver: Driver<[WorkoutIconItem]>) {
        let dataSource = RxTableViewSectionedReloadDataSource<IconSectionModel>(configureCell: { (dataSource, table, idxPath, _) in
            let workoutIconItem = dataSource[idxPath]
            let iconCell = table.dequeueReusableCell(withIdentifier: "WorkoutIconCell", for: idxPath) as! WorkoutIconCell
            iconCell.setData(icon: workoutIconItem.workoutIcon, selected: workoutIconItem.selected)
            return iconCell
        })
        
        iconItemsDriver
            .map { icons in
                return [IconSectionModel(items: icons)]
            }
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .map { indexPath in
                return (indexPath, dataSource[indexPath])
            }
            .subscribe(onNext: { [weak self] pair in
                self?.presenter.onIconSelected(icon: pair.1.workoutIcon)
            })
            .disposed(by: disposeBag)
    }
    
}


class IconSectionModel: SectionModelType {
    typealias Item = WorkoutIconItem
    
    var items: [WorkoutIconItem]
    
    required init(original: IconSectionModel, items: [WorkoutIconItem]) {
        self.items = items
    }
    
    init(items: [WorkoutIconItem]) {
        self.items = items
    }
}
