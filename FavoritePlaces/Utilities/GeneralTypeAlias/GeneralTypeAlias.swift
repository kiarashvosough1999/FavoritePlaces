//
//  GeneralTypeAlias.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/4/1400 AP.
//

import Foundation

struct GeneralTypeAlias {
    typealias DataCompletion<T> = ((T) -> Void)
    typealias DataReceive<T> = (() -> T)
    typealias Completion = (() -> Void)
    typealias ViewModelBasicSignal = () -> Void
    typealias ViewModelTextSignal = () -> String?
    typealias ViewModelSetTextSignal = (String?) -> Void
}
