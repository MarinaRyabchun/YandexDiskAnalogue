//
//  PublishedFiles+CoreDataProperties.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 15.04.2023.
//
//

import Foundation
import CoreData


extension PublishedFiles {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PublishedFiles> {
        return NSFetchRequest<PublishedFiles>(entityName: "PublishedFiles")
    }

    @NSManaged public var file: String?
    @NSManaged public var name: String?
    @NSManaged public var preview: String?
    @NSManaged public var created: String?
    @NSManaged public var path: String?
    @NSManaged public var modified: String?
    @NSManaged public var type: String?
    @NSManaged public var mime_type: String?
    @NSManaged public var size: Int64

}

extension PublishedFiles : Identifiable {

}
