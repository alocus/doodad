//
//  ItemType+CoreDataProperties.swift
//  Doodad
//
//  Created by Michael Dunn on 2016-09-14.
//  Copyright © 2016 Michael Dunn. All rights reserved.
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType");
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
