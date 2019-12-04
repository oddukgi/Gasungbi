//
//  KeywordProtocol.swift
//  Gasungbi
//
//  Created by 강선미 on 04/12/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation
import CoreData

protocol KeywordProtocol {
  
    // save keyword
   func setKeyword(item: String,usingContext context: NSManagedObjectContext) -> Keyword
   // get fetched results
   func deleteKeyword(keyword: Keyword, fromContext context: NSManagedObjectContext)

    
}
