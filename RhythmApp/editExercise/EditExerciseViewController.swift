//
//  EditExerciseViewController.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 23/09/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import UIKit


class EditExerciseViewController: UIViewController, EditExerciseViewProtocol, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var presenter: EditExercisePresenterProtocol!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var durationPicker: UIPickerView!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var bgView: UIView!
    @IBOutlet weak var soundPickerContainer: UIView!
    @IBOutlet weak var soundNameLabel: UILabel!
    @IBOutlet weak var chooseSoundButton: UIButton!
    
    
    private var minutesItems: [Int] = []
    private var secondsItems: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewDidLoad()
        
        nameTextField.layer.borderColor = UIColor.white.cgColor
        nameTextField.layer.borderWidth = 1.0
        nameTextField.layer.cornerRadius = 10
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Exercise name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        nameTextField.delegate = self
        
        soundPickerContainer.layer.borderColor = UIColor.white.cgColor
        soundPickerContainer.layer.borderWidth = 1.0
        soundPickerContainer.layer.cornerRadius = 10
        
        durationPicker.dataSource = self
        durationPicker.delegate = self
        durationPicker.showsSelectionIndicator = false
        durationPicker.layer.cornerRadius = 8
        durationPicker.layer.borderWidth = 1.0
        durationPicker.layer.borderColor = UIColor.white.cgColor
    }
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    func setPickersData(minutesData: [Int], secondsData: [Int]) {
        minutesItems = minutesData
        secondsItems = secondsData
        durationPicker.reloadAllComponents()
    }
    
    func setData(name: String) {
        if !nameTextField.isFirstResponder {
            nameTextField.text = name
        }
    }
    
    func setWorkoutColor(_ workoutColor: WorkoutColor) {
        bgView.backgroundColor = WorkoutColorUtil.getUIColorForWorkoutColor(workoutColor)
    }
    
    func setSaveButtonEnabled(_ enabled: Bool) {
        saveButton.isEnabled = enabled
    }
    
    @IBAction func onCancelButtonClick(_ sender: UIButton) {
        presenter.onCancelButtonClick()
    }
    
    @IBAction func onSaveButtonClick(_ sender: UIButton) {
        presenter.onSaveButtonClick()
    }
    
    @IBAction func onChooseSoundButtonClick(_ sender: UIButton) {
        presenter.onChooseSoundButtonClick()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return true
        }
        presenter.onNameChanged(name: newText)
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return minutesItems.count
        } else {
            return secondsItems.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            presenter.onDurationMinutesChanged(minutes: minutesItems[row])
        } else {
            presenter.onDurationSecondsChanged(seconds: secondsItems[row])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let text = component == 0 ? minutesItems[row].description : formatSeconds(secondsItems[row])
        if let label = view as? UILabel {
            label.text = text
            return label
        } else {
            let label = UILabel()
            label.text = text
            label.textAlignment = .center
            label.textColor = UIColor.white
            return label
        }
    }
    
    private func formatSeconds(_ seconds: Int) -> String {
        var str = seconds.description
        if str.count < 2 {
            str = "0" + str
        }
        return str
    }
}
