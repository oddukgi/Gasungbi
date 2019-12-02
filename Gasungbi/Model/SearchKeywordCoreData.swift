//
//  SearchKeywordCoreData.swift
//  Gasungbi
//
//  Created by 강선미 on 29/11/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation
import CoreData
 
struct SearchKeywordCoreData: SearchKeywordCoreDataProtocol {
    
    static let shared: SearchKeywordCoreData = SearchKeywordCoreData()
       
    private init() {}
 
    func addKeyword(keyword: String,fromContext context: NSManagedObjectContext) {
        let searchKeyword = SearchKeyword(context: context)
        searchKeyword.keyword = keyword
    }
    
    func saveCellData(usingContext context: NSManagedObjectContext,searchResult: SearchResults) -> SearchKeyword {
        let item = SearchKeyword(context: context)
        item.title = searchResult.title
        item.link = searchResult.link
        item.hprice = searchResult.hprice
        item.lprice = searchResult.lprice
        item.image = searchResult.image
        item.mallName = searchResult.mallName
        
        return item
    }
    
    
    func addFavoriteItem(searchResult: SearchResults, inFavorite favorite: FavoriteItem) -> FavoriteItem {
        
        guard let context = favorite.managedObjectContext else { preconditionFailure("Failed to get favorite context.") }
        let item = FavoriteItem(context: context)
        item.title = searchResult.title
        item.link = searchResult.link
        item.hprice = searchResult.hprice
        item.lprice = searchResult.lprice
        item.image = searchResult.image
        item.mallName = searchResult.mallName
        item.selected = false
     
        return item
    }

    func getFetchedResultsController(fromContext context: NSManagedObjectContext) -> NSFetchedResultsController<SearchKeyword>
    {
        let fetchRequest: NSFetchRequest<SearchKeyword> = SearchKeyword.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: false)
      
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    func deleteKeyword(at indexPath: IndexPath,fromContext context: NSManagedObjectContext, fetchController: NSFetchedResultsController<SearchKeyword>) {
        let keywordToDelete = fetchController.object(at: indexPath)
        context.delete(keywordToDelete)
        try? context.save()
        
    }

   
}
