//
//  SearchItem+CoreDataClass.swift
//  
//
//  Created by 강선미 on 04/12/2019.
//
//

import Foundation
import CoreData


class SearchItem: NSManagedObject {
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        select = false

    }
}
