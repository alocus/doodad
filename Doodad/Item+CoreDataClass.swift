//
//  Item+CoreDataClass.swift
//  Doodad
//
//  Created by Michael Dunn on 2016-09-14.
//  Copyright © 2016 Michael Dunn. All rights reserved.
//

import Foundation
import CoreData


open class Item: NSManagedObject {
    
    open override func awakeFromInsert() {
        super.awakeFromInsert()
        
        // time stamp for item
        self.created = Date()
    }

}
