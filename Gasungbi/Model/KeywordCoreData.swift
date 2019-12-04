//
//  KeywordCoreData.swift
//  Gasungbi
//
//  Created by 강선미 on 04/12/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation
import CoreData

struct KeywordCoreData: KeywordProtocol {
  
    static let shared: KeywordCoreData = KeywordCoreData()
    
    // save keyword
    func setKeyword(item: String, usingContext context: NSManagedObjectContext) -> Keyword {
        let keyword = Keyword(context: context)
        keyword.recentString = item
        
        return keyword
    }
   // get fetched results
    func deleteKeyword(keyword: Keyword, fromContext context: NSManagedObjectContext) {
        context.delete(keyword)

        do {
            try context.save()
        } catch {
            print("Error deleting pin: \(error)")
        }
    }
    
    
}