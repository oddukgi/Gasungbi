//
//  SearchKeywordProtocol.swift
//  Gasungbi
//
//  Created by 강선미 on 29/11/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation
import CoreData

protocol SearchKeywordCoreDataProtocol {
    
    func addKeyword(keyword: String,fromContext context: NSManagedObjectContext) 
    func saveCellData(usingContext context: NSManagedObjectContext,searchResult: SearchResults) -> SearchKeyword
    func addFavoriteItem(searchResult: SearchResults, inFavorite favorite: FavoriteItem) -> FavoriteItem
    
    func getFetchedResultsController(fromContext context: NSManagedObjectContext) -> NSFetchedResultsController<SearchKeyword>
    func deleteKeyword(at indexPath: IndexPath, fromContext context: NSManagedObjectContext, fetchController: NSFetchedResultsController<SearchKeyword>)
}

