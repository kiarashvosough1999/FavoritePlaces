//
//  AddFriendViewController.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import UIKit

final class AddFriendViewController: UIViewController, ViewProtocol, MVVMView {

    var viewModel: AddFriendViewModel!
    
    fileprivate let viewMaker = ViewMaker()
    
    // MARK: - Views
    
    fileprivate lazy var nameTextField = viewMaker
        .textField
        .with(style: AppStyle.TextField().nameTextField())
    
    fileprivate lazy var lastNameTextField = viewMaker
        .textField
        .with(style: AppStyle.TextField().lastNameTextField())
    
    fileprivate lazy var saveButton = viewMaker
        .button
        .with(style: AppStyle.Button().addFriendSaveButton())
    
    fileprivate lazy var cancelButton = viewMaker
        .button
        .with(style: AppStyle.Button().addFriendCancelButton())
    
    fileprivate lazy var stackView = viewMaker
        .stackView
        .with(style: AppStyle.StackView().inputFieldStackView())
    
    fileprivate lazy var buttonStackView = viewMaker
        .stackView
        .with(style: AppStyle.StackView().saveButtonStackView())
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        configureView()
        constraintViews()
        addTargets()
        viewModel.setupEditModeIfNeeded()
    }
    
    func setupBindings() {
        viewModel.getLastNameText = { [weak self] in
            guard let strongSelf = self else { return nil }
            return strongSelf.lastNameTextField.text
        }
        
        viewModel.getNameText = { [weak self] in
            guard let strongSelf = self else { return nil }
            return strongSelf.nameTextField.text
        }
        
        viewModel.$shakeNameTextField.byWrapping(self) { strongSelf in
            strongSelf.nameTextField.shake()
        }
        
        viewModel.$shakeLastNameTextField.byWrapping(self) { strongSelf in
            strongSelf.lastNameTextField.shake()
        }
        
        viewModel.$setNameText.byWrapping(self) { strongSelf, text in
            strongSelf.nameTextField.text = text
        }
        
        viewModel.$setLastNameText.byWrapping(self) { strongSelf, text in
            strongSelf.lastNameTextField.text = text
        }
    }
    
    func configureView() {
        title = viewModel.title
        view.backgroundColor = Palette.whiteTwo
    }
    
    func constraintViews() {
        addViews(stackView)
        
        buttonStackView.addArrangedSubview(saveButton)
        buttonStackView.addArrangedSubview(cancelButton)
        
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(lastNameTextField)
        stackView.addArrangedSubview(buttonStackView)
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25)
        ])
    }
    
    func addTargets() {
        saveButton.addTarget(viewModel, action: #selector(viewModel.saveButtonDidTaped), for: .touchUpInside)
        cancelButton.addTarget(viewModel, action: #selector(viewModel.cancelButtonDidTaped), for: .touchUpInside)
    }
    
}
