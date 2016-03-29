//
//  TaskDuration+CoreDataProperties.swift
//  MagicTasks
//
//  Created by Luiz Bildzinkas on 3/27/16.
//  Copyright © 2016 Luiz Bildzinkas. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension TaskDuration {

    @NSManaged var durationEnd: NSDate?
    @NSManaged var durationInit: NSDate?
    @NSManaged var task: Task?

}
