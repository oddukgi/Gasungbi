//
//  SearchKeyword+CoreDataClass.swift
//  
//
//  Created by 강선미 on 29/11/2019.
//
//

import Foundation
import CoreData

class SearchKeyword: NSManagedObject {
    override func awakeFromInsert() {
        super.awakeFromInsert()
        favoriteItem = FavoriteItem(context: managedObjectContext!)
    }
}
