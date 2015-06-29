//
//  Person.swift
//  
//
//  Created by Damodar Patel on 6/15/15.
//
//

import Foundation
import CoreData

class Person: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var cell: Double
    @NSManaged var address: String

}
