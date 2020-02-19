//
//  EditWorkoutViewController.swift
//  RhythmApp
//
//  Created by Svetlana Gladysheva on 26/08/2019.
//  Copyright © 2019 Svetlana Gladysheva. All rights reserved.
//

import UIKit


class EditWorkoutViewController: UIViewController, EditWorkoutViewProtocol, UITextFieldDelegate, UITextViewDelegate {
    
    var presenter: EditWorkoutPresenterProtocol!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var descriptionTextView: TextViewWithPlaceholder!
    @IBOutlet private weak var colorPicker: ColorPicker!
    @IBOutlet private weak var iconPicker: IconPicker!
    @IBOutlet private weak var bgView: UIView!
    @IBOutlet private weak var titleBgView: UIView!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var saveButton: UIButton!
    
    
    init() {
        super.init(nibName: "EditWorkoutViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewDidLoad()
        
        nameTextField.layer.borderColor = UIColor.white.cgColor
        nameTextField.layer.borderWidth = 1.0
        nameTextField.layer.cornerRadius = 10
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Workout name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        descriptionTextView.layer.borderColor = UIColor.white.cgColor
        descriptionTextView.layer.borderWidth = 1.0
        descriptionTextView.layer.cornerRadius = 10
        descriptionTextView.placeholder = "Workout description"
        descriptionTextView.placeholderColor = UIColor.white
        
        nameTextField.delegate = self
        descriptionTextView.delegate = self
        
        colorPicker.setColorClickCallback(callback: { [unowned self] newColor in
            self.presenter.onColorChanged(color: newColor)
        })
        
        iconPicker.setIconClickCallback(callback: { [unowned self] newIcon in
            self.presenter.onIconChanged(icon: newIcon)
        })
    }
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    func setData(name: String, description: String, color: WorkoutColor, icon: WorkoutIcon) {
        if !nameTextField.isFirstResponder {
            nameTextField.text = name
        }
        if !descriptionTextView.isFirstResponder {
            descriptionTextView.text = description
        }
        
        colorPicker.setChosenColor(chosenColor: color)
        iconPicker.setChosenItem(chosenItem: icon)
        bgView.backgroundColor = WorkoutColorUtil.getUIColorForWorkoutColor(color)
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return true
        }
        presenter.onNameChanged(name: newText)
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        presenter.onDescriptionChanged(description: textView.text)
    }
}
