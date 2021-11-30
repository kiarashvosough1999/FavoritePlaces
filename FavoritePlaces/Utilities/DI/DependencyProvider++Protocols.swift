//
//  DependencyProvider++Protocols.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import Foundation
import CoreData

protocol BaseDependencyProvider { }

protocol DataBaseContextDependencyProvider: BaseDependencyProvider {
    var contex: CD { get }
}
