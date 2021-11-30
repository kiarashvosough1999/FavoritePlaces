//
//  AddFriendViewModel.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import Foundation

final class AddFriendViewModel: MVVMViewModel {
    
    weak var coordinatorDelegate: AddFriendViewModelCoordination?
    
    // MARK: - Closure Binding
    
    @MainQueue1 var setNameText: GeneralTypeAlias.ViewModelSetTextSignal?
    
    @MainQueue1 var setLastNameText: GeneralTypeAlias.ViewModelSetTextSignal?
    
    var getNameText: GeneralTypeAlias.ViewModelTextSignal?
    
    var getLastNameText: GeneralTypeAlias.ViewModelTextSignal?
    
    @MainQueue var shakeNameTextField: GeneralTypeAlias.ViewModelBasicSignal?
    
    @MainQueue var shakeLastNameTextField: GeneralTypeAlias.ViewModelBasicSignal?
    
    // MARK: - LifeCycle
    
    fileprivate let dependencies: AddFriendViewModelDependencyProvider
    
    init(dependencies: AddFriendViewModelDependencyProvider) {
        self.dependencies = dependencies
    }
    
    func setupEditModeIfNeeded() {
        guard let model = dependencies.friendModel else { return }
        $setNameText.execute(model.name)
        $setLastNameText.execute(model.familyName)
    }
    
    @objc func cancelButtonDidTaped() {
        coordinatorDelegate?.didCompleteSaving()
    }
    
    @objc func saveButtonDidTaped() {
        guard let name = getNameText?(), name.isEmpty.not else {
            $shakeNameTextField.execute()
            return
        }
        
        guard let lastName = getLastNameText?(), lastName.isEmpty.not else {
            $shakeLastNameTextField.execute()
            return
        }
        
        if dependencies.friendModel.isNil {
            let model = PersonModel(name: name, familyName: lastName)
            try? Person.insert(model, with: dependencies.contex.mainContext)
        }
        else {
            let model = PersonModel(identifier: dependencies.friendModel!.identifier, name: name, familyName: lastName)
            try? Person.update(model, with: dependencies.contex.mainContext)
        }
        
        coordinatorDelegate?.didCompleteSaving()
    }
}

protocol AddFriendViewModelDependencyProvider: DataBaseContextDependencyProvider {
    var friendModel: AddFriendPersonModel? { get set }
}
