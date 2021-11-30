//
//  String++Localizable.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import Foundation

extension String: Localizable {
    static func localize(_ string: LocalizedStrings) -> String {
        return string.rawValue.replacingOccurrences(of: "_", with: " ")
    }
}
