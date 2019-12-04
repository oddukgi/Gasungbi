//
//  FavoritesProtocol.swift
//  Gasungbi
//
//  Created by 강선미 on 04/12/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation
import CoreData

protocol FavoritesProtocol {
    
    // save keyword
    func createFavorites(selectedItems: [SearchResults],  forSearch searchitem: SearchItem) -> Favorites
    
    func getFetchedResultsController(fromContext context: NSManagedObjectContext) -> NSFetchedResultsController<Favorites>
}

