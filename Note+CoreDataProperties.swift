//
//  Note+CoreDataProperties.swift
//  NotesMobileApp
//
//  Created by Mac User on 17/12/23.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var details: String?
    @NSManaged public var date: String?

}

extension Note : Identifiable {

}
