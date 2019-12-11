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
    func createFavorites(selectedItems: [SearchResults], forSearch searchitem: SearchItem) {
        guard let context = searchitem.managedObjectContext else { preconditionFailure("SearchItem does not have a context.") }

        var index = 0
       
        selectedItems.forEach { (select) in
            let favorites = Favorites(context: context)
            favorites.setValue(select.title, forKey: "title")
            favorites.setValue(select.link, forKey: "link")
            favorites.setValue(select.hprice, forKey: "hprice")
            favorites.setValue(select.lprice, forKey: "lprice")
            favorites.setValue(select.image, forKey: "image")
            favorites.setValue(select.mallName, forKey: "mallName")
            let stringIndex = String(index)
            favorites.setValue(stringIndex, forKey: "index")
            favorites.setValue(true, forKey: "select")
            searchitem.favorites = favorites

            index += 1
        }
         // 값을 설정한 뒤에 Core Data에 저장한다.
        do {
            try context.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    

    func getFetchedResultsController(fromContext context: NSManagedObjectContext) ->NSFetchedResultsController<Favorites>
    {
          let fetchRequest: NSFetchRequest<Favorites> = Favorites.fetchRequest()
          let sortDescriptor = NSSortDescriptor(key: "index", ascending: true)
 //         let predicate = NSPredicate(format: "searchitemx == %@", searchitem)
//          fetchRequest.predicate = predicate
          fetchRequest.sortDescriptors = [sortDescriptor]
          
          return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context,sectionNameKeyPath: nil, cacheName: nil)
    }
          
  
}
