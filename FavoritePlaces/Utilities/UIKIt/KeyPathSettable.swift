//
//  KeyPathSettable.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/4/1400 AP.
//

import UIKit

public protocol KeyPathSettable {}

extension KeyPathSettable {
    
    public func set<Value>(
        _ keyPath: WritableKeyPath<Self, Value>,
        to value: Value
    ) -> Self {
        
        var mutableSelf = self
        mutableSelf[keyPath: keyPath] = value
        return mutableSelf
    }
}

extension KeyPathSettable {
    
    public func setup(_ setup: (inout Self) -> Void) -> Self {
        var mutableSelf = self
        setup(&mutableSelf)
        return mutableSelf
    }
}

extension UIView: KeyPathSettable {}

extension UIViewController: KeyPathSettable {}
