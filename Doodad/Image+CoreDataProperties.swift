//
//  Image+CoreDataProperties.swift
//  Doodad
//
//  Created by Michael Dunn on 2016-09-14.
//  Copyright © 2016 Michael Dunn. All rights reserved.
//

import Foundation
import CoreData


extension Image {

    @nonobjc open override class func fetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        return NSFetchRequest<Image>(entityName: "Image") as! NSFetchRequest<NSFetchRequestResult>;
    }

    @NSManaged public var image: NSObject?
    @NSManaged public var toItem: Item?
    @NSManaged public var toStore: NSSet?

}

// MARK: Generated accessors for toStore
extension Image {

    @objc(addToStoreObject:)
    @NSManaged public func addToToStore(_ value: Store)

    @objc(removeToStoreObject:)
    @NSManaged public func removeFromToStore(_ value: Store)

    @objc(addToStore:)
    @NSManaged public func addToToStore(_ values: NSSet)

    @objc(removeToStore:)
    @NSManaged public func removeFromToStore(_ values: NSSet)

}
