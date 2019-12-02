//
//  FavoriteItemCoreData.swift
//  Gasungbi
//
//  Created by 강선미 on 29/11/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation
import CoreData

struct FavoriteItemCoreData: FavoriteItemProtocol {

    static let shared = FavoriteItemCoreData()
    
    //getFetchedFavoritesController
    
    func getFetchedResultsController(fromContext context: NSManagedObjectContext) -> NSFetchedResultsController<FavoriteItem>
     {
         let fetchRequest: NSFetchRequest<FavoriteItem> = FavoriteItem.fetchRequest()
         let sortDescriptor = NSSortDescriptor(key: "title", ascending: false)
       
         fetchRequest.sortDescriptors = [sortDescriptor]
         
         return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
     }
    
    func setFetchedResultsController(fromContext context: NSManagedObjectContext) -> NSFetchedResultsController<FavoriteItem>
     {
         let fetchRequest: NSFetchRequest<FavoriteItem> = FavoriteItem.fetchRequest()
         let sortDescriptor = NSSortDescriptor(key: "title", ascending: false)

        fetchRequest.sortDescriptors = [sortDescriptor]

        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
     
     }
    
    
    func deleteFavoriteItems(fetchController: NSFetchedResultsController<FavoriteItem>,toFavoriteItem favoriteItem: FavoriteItem
    ,fromContext context: NSManagedObjectContext) {

        fetchController.fetchedObjects?.forEach { (favoriteItem) in
            context.delete(favoriteItem)
        }

//        do {
//             try context.save()
//        } catch {
//            print("Unable to save context after clearing album")
//        }
    }
    
    func addFavoriteItems(selectedItems: [SearchResults], toFavoriteItem favoriteItem: FavoriteItem)
    {
        guard let context = favoriteItem.managedObjectContext else { preconditionFailure("Album does not have a context.") }

         selectedItems.forEach { (select) in
            _ = SearchKeywordCoreData.shared.addFavoriteItem(searchResult: select, inFavorite: favoriteItem)
         }

        print(selectedItems.count)
        try? context.save()

    }
}
