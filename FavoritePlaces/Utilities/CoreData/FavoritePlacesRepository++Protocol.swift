//
//  FavoritePlacesRepository++Protocol.swift
//  FavoritePlaces
//
//  Created by Kiarash Vosough on 9/8/1400 AP.
//

import CoreData
import UIKit

protocol FRCBaseRepository: NSObjectProtocol {
    
    typealias OnContentChangedSnapshot = (_ snapshot: NSDiffableDataSourceSnapshotReference) -> Void
    
    typealias OnContentChangeDiffID = (_ diff: CollectionDifference<NSManagedObjectID>) -> Void

    typealias OnIndexChanged = (_ object: Any, _ lastIndex: IndexPath?,_ type: NSFetchedResultsChangeType,_ newIndexPath: IndexPath?) -> Void
    
    typealias OnSectionInfoChanged = (_ sectionInfo: NSFetchedResultsSectionInfo,_ sectionIndex: Int,_ type: NSFetchedResultsChangeType) -> Void
    
    var onContentChangedSnapshot: OnContentChangedSnapshot? { get set }
    
    var onContentChangedIDs: OnContentChangeDiffID? { get set }
     
    var onIndexChanged: OnIndexChanged? { get set }
    
    var onSectionInfoChanged: OnSectionInfoChanged? { get set }
    
    func performFetchWithFRC() throws
}

extension FRCBaseRepository {
    
    var onContentChangedSnapshot: OnContentChangedSnapshot? {
        get {
            nil
        }
        set {
            
        }
    }
    
    var onContentChangedIDs: OnContentChangeDiffID? {
        get {
            nil
        }
        set {
            
        }
    }
     
    var onIndexChanged: OnIndexChanged? {
        get {
            nil
        }
        set {
            
        }
    }
    
    var onSectionInfoChanged: OnSectionInfoChanged? {
        get {
            nil
        }
        set {
            
        }
    }
}
