//
//  SearchItemProtocol.swift
//  Gasungbi
//
//  Created by 강선미 on 04/12/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation
import CoreData

protocol SearchItemProtocol {
    
    // save keyword
    func saveResults(searchResult: SearchResults,fromContext context: NSManagedObjectContext,index: Int)-> SearchItem
    
    func getFetchedResultsController(forFavorites favorites: Favorites,fromContext context: NSManagedObjectContext) -> NSFetchedResultsController<SearchItem>
}
