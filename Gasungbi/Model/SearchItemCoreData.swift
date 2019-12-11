//
//  SearchItemCoreData.swift
//  Gasungbi
//
//  Created by 강선미 on 04/12/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation
import CoreData

    // save keyword
struct SearchItemCoreData: SearchItemProtocol {
    
    static let shared: SearchItemCoreData = SearchItemCoreData()
    
    
    func saveResults(searchResult: SearchResults,fromContext context: NSManagedObjectContext,index: Int)-> SearchItem {
    
       let item = SearchItem(context: context)
       item.title = searchResult.title
       item.link = searchResult.link
       item.hprice = searchResult.hprice
       item.lprice = searchResult.lprice
       item.image = searchResult.image
       item.mallName = searchResult.mallName
       item.image = searchResult.image
       let stringValue = String(index)
       item.index = stringValue
        
        return item
 
    }

    func getFetchedResultsController(forFavorites favorites: Favorites,fromContext context: NSManagedObjectContext) -> NSFetchedResultsController<SearchItem>
    {
        let fetchRequest: NSFetchRequest<SearchItem> = SearchItem.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: false)
        let predicate = NSPredicate(format: "favorites == %@", favorites)
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
}
