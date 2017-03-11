//
//  Favourite+CoreDataProperties.swift
//  ScoreBoard
//
//  Created by Abhishek Thapliyal on 3/11/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import Foundation
import CoreData


extension Favourite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favourite> {
        return NSFetchRequest<Favourite>(entityName: "Favourite");
    }

    @NSManaged public var id: String?
    @NSManaged public var favourite: Bool
    @NSManaged public var country: String?
    @NSManaged public var matches: String?
    @NSManaged public var playerDesc: String?
    @NSManaged public var runs: String?
    @NSManaged public var name: String?

}
