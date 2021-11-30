//
//  UserDefaultsPropertyWrapper+Extensions.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/4/1400 AP.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    
    let key: UserDefaultsConfig.UserDefaultsKey
    let defaultValue: T

    init(_ key: UserDefaultsConfig.UserDefaultsKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key.rawValue) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}
