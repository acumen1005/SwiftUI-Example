//
//  Favorite+CoreDataProperties.swift
//  favorite
//
//  Created by 谷雷雷 on 2020/6/4.
//  Copyright © 2020 acumen. All rights reserved.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }
    
    @NSManaged public var imageUrl: String?
    @NSManaged public var desc: String?
    @NSManaged public var name: String?
    @NSManaged public var updateTime: Date?
    @NSManaged public var createTime: Date?
    @NSManaged public var isDone: Bool
    @NSManaged public var uuid: UUID?
    
    
    public var createTimeStr: String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        if let create = self.createTime {
            return format.string(from: create);
        }
        return ""
    }

    @discardableResult
    class func create(name: String,
                      desc: String = "",
                      icon: String? = nil,
                      in context: NSManagedObjectContext) -> Favorite {
        let newFavorite = Favorite(context: context)
        newFavorite.uuid = UUID()
        newFavorite.imageUrl = icon
        newFavorite.name = name
        newFavorite.desc = desc
        newFavorite.isDone = false
        newFavorite.createTime = Date()
        newFavorite.updateTime = Date()
        return newFavorite
    }
    
    class func simple() -> Favorite {
        let f = Favorite.create(name: "demo", desc: "desc demo", in: PersistenceManager().managedObjectContext)
        return f;
    }
}

extension Favorite {
    static func == (lhs: Favorite, rhs: Favorite) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
