//
//  FavoritesCoreData.swift
//  Gasungbi
//
//  Created by 강선미 on 04/12/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation
import CoreData

    // save keyword
struct FavoritesCoreData: FavoritesProtocol {
    
    static let shared: FavoritesCoreData = FavoritesCoreData()
 
    // save keyword
    func createFavorites(selectedItems: [SearchResults], forSearch searchitem: SearchItem) -> Favorites {
        guard let context = searchitem.managedObjectContext else { preconditionFailure("SearchItem does not have a context.") }

        var index = 0
        var favorites = Favorites(context: context)
        var favoriteArray:[Favorites] = []
        selectedItems.forEach { (select) in
            let fav = SearchItemCoreData.shared.addFavoriteItem(searchResult: select, forFavorites: favorites,index: index)
            
            if fav.title?.isEmpty == true { return }
            favorites = fav
            searchitem.favorites = favorites
            
            try? context.save()
 
            favoriteArray.append(favorites)
            index += 1
        }

        print(selectedItems.count)
        print(favoriteArray.count)
      
        return favorites
    }

    func getFetchedResultsController(fromContext context: NSManagedObjectContext) -> NSFetchedResultsController<Favorites>
      {
          let fetchRequest: NSFetchRequest<Favorites> = Favorites.fetchRequest()
          let sortDescriptor = NSSortDescriptor(key: "title", ascending: false)
//          let predicate = NSPredicate(format: "searchitemx == %@", searchitem)
//          fetchRequest.predicate = predicate
          fetchRequest.sortDescriptors = [sortDescriptor]
          
          return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
      }
      
}
