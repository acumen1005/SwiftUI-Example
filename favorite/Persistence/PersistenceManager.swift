//
//  PersistenceManager.swift
//  favorite
//
//  Created by 谷雷雷 on 2020/6/4.
//  Copyright © 2020 acumen. All rights reserved.
//

import Foundation
import CoreData


class PersistenceManager {
    lazy var managedObjectContext: NSManagedObjectContext = { self.persistentContainer.viewContext }()
    
    lazy var persistentContainer: NSPersistentContainer  = {
        let container = NSPersistentContainer(name: "Favorite")
        container.loadPersistentStores { (persistentStoreDescription, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
        return container
    }()
}
