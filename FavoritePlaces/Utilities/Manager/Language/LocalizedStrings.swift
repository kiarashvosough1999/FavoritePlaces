//
//  LocalizedStrings.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import Foundation

enum LocalizedStrings: String {
    case friends
    case friends_List
    case choose_friend
    case choose_location
    case find
    case edit
    case delete
    case enter_your_name
    case enter_your_last_name
    case save
    case error_on_saving_location
    case error
    case ok
    case next
    case cancel
    case data_is_missing
    case choose_at_least_one_location
}

protocol Localizable {
    
    static func localize(_ string: LocalizedStrings) -> String
    
}
