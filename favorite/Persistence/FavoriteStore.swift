//
//  FavoriteStore.swift
//  favorite
//
//  Created by 谷雷雷 on 2020/6/4.
//  Copyright © 2020 acumen. All rights reserved.
//

import UIKit
import Combine
import CoreData

class FavoriteStore: NSObject {
    
    private let persistenceManager = PersistenceManager()
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Favorite> = {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createTime", ascending: false)]
        
        let fetechedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: self.persistenceManager.managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        fetechedResultsController.delegate = self
        return fetechedResultsController
    }()
    
    private var favorites: [Favorite] {
        return fetchedResultsController.fetchedObjects ?? []
    }
    
    private var undoneFavorites: [Favorite] {
        return favorites.filter { !$0.isDone }
    }
    
    private var doneFavorites: [Favorite] {
        return favorites.filter { $0.isDone }
    }
    
    public var undoneList: [Favorite] = []
    public var doneList: [Favorite] = []
    
    let didChange = PassthroughSubject<FavoriteStore, Never>()
    
    override init() {
        super.init()
        fetchFavorites()
        self.undoneList = undoneFavorites
        self.doneList = doneFavorites
    }
    
    public func create(name: String, desc: String = "", icon: String? = nil) -> Favorite {
        let f = Favorite.create(
            name: name,
            desc: desc,
            icon: icon,
            in: persistenceManager.managedObjectContext
        )
        saveChanges()
        return f
    }
    
    public func delete(_ object: Favorite) {
        undoneList.removeAll { object.uuid == $0.uuid }
        persistenceManager.managedObjectContext.delete(object)
        saveChanges()
    }
    
    public func done(favorite item: Favorite) {
        item.isDone = true
        do {
            try update(favorite: item)
        } catch let e {
            print("error = \(e)")
        }
    }
    
    private func update(favorite item: Favorite) throws {
        guard let uuid = item.uuid else {
            return
        }
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        let predicate = NSPredicate(format: "uuid = %@", argumentArray: [uuid])
        fetchRequest.predicate = predicate
        do {
            let rs = try fetchedResultsController.managedObjectContext.fetch(fetchRequest)
            if let fav = rs.first {
                fav.desc = item.desc
                fav.name = item.name
                fav.isDone = item.isDone
                fav.imageUrl = item.imageUrl
                fav.updateTime = Date()
                saveChanges()
            } else {
                // TODO: throw Error
            }
        } catch let error {
            throw error
        }
    }
    
    private func fetchFavorites() {
        do {
            try fetchedResultsController.performFetch()
            dump(fetchedResultsController.sections)
        } catch {
            fatalError()
        }
    }
    
    private func saveChanges() {
        guard persistenceManager.managedObjectContext.hasChanges else { return }
        do {
            try persistenceManager.managedObjectContext.save()
        } catch { fatalError() }
    }
}

extension FavoriteStore: ObservableObject {
    
}

extension FavoriteStore: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        didChange.send(self)
    }
}
