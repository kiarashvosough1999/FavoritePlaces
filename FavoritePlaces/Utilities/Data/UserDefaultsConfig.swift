//
//  UserDefaultsConfig.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/4/1400 AP.
//

import Foundation

struct UserDefaultsConfig {
    
    enum UserDefaultsKey: String {
        case appleLanguages  = "AppleLanguages"
        case currentLanguage
        case googleAPIToken
    }
    
    @UserDefault(.currentLanguage, defaultValue: "en")
    static var currentLanguage: String
    
    @UserDefault(.appleLanguages, defaultValue: ["en"])
    static var appleLanguage: [String]
    
    @UserDefault(.googleAPIToken, defaultValue: "AIzaSyCDdYcVjz_0N1ZKEAjmzArjn63Ec8y__5k")
    static var googleAPIToken: String
    
    static func clearUserDefaultFor(_ key: UserDefaultsKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func clearAllUserDefault() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
        UserDefaults.standard.synchronize()
    }
}
