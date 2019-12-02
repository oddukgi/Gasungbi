//
//  FavoriteItemProtocol.swift
//  Gasungbi
//
//  Created by 강선미 on 29/11/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation
import CoreData

protocol FavoriteItemProtocol {
   
    func getFetchedResultsController(fromContext context: NSManagedObjectContext) -> NSFetchedResultsController<FavoriteItem>
    
    func setFetchedResultsController(fromContext context: NSManagedObjectContext) -> NSFetchedResultsController<FavoriteItem>
    
    func deleteFavoriteItems(fetchController: NSFetchedResultsController<FavoriteItem>,toFavoriteItem favoriteItem: FavoriteItem,fromContext context: NSManagedObjectContext)
    func addFavoriteItems(selectedItems: [SearchResults], toFavoriteItem favoriteItem: FavoriteItem)
}
