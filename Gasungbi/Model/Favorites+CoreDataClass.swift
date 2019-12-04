//
//  Favorites+CoreDataClass.swift
//  
//
//  Created by 강선미 on 04/12/2019.
//
//

import Foundation
import CoreData


class Favorites: NSManagedObject {
    
    // get select
    var isSelected: Bool {
        return (searchitems?.select ?? false) == false
    }
    
    var getIndex: String {
        return searchitems?.index ?? ""
    }
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        searchitems = SearchItem(context: managedObjectContext!)
    }
}
