//
//  FPError.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/5/1400 AP.
//

import Foundation

enum FPError: Error {
    
    case dbError(reason: DBError)
    case noError
    
    public enum DBError: Error {
        
        case CannotCreate
        case CannotFindObject
        case WriteContextNotExist
        case ReadContextNotExist
        case CannotFetch
        case CannotFetchInObserveMode
        case CannotDelete
        case CannotSave
        case CannotUpdate
        case CannotMap
        case CannotSetRelationShip

    }
    
    var isErrorOccured: Bool {
        switch self {
        case .noError: return false
        default: return true
        }
    }
}

extension Error {
    
    var asFPError: FPError? {
        self as? FPError
    }
    
    var asFPErrorUnsafe: FPError {
        self as! FPError
    }

    func asFPError(orFailWith message: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line) -> FPError {
        guard let afError = self as? FPError else {
            fatalError(message(), file: file, line: line)
        }
        return afError
    }

    func asFPError(or defaultAFError: @autoclosure () -> FPError) -> FPError {
        self as? FPError ?? defaultAFError()
    }
}
