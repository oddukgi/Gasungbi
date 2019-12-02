//
//  SearchResults.swift
//  Gasungbi
//
//  Created by 강선미 on 21/11/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation
import ObjectMapper

// MARK: ProductPriceData


struct SearchResultsGroup: Mappable {
    var lastBuildDate: String?
    var total: String?
    var start: String?
    var display: String?
    var items: [SearchResults] = []
    
    init?(map: Map) {}

    
    mutating func mapping(map: Map) {
        self.lastBuildDate <- map["lastBuildDate"]
        self.total <- map["total"]
        self.start <- map["start"]
        self.display <- map["display"]
        self.items <- map["items"]
    }
}


struct SearchResults: Mappable {
    var title: String?
    var link: String?
    var image: String?
    var lprice: String?
    var hprice: String?
    var mallName: String?
    var productId: String?
    var productType: String?
    var isSelected = false
    
    init?(map: Map) {}

    mutating func mapping(map: Map) {
        self.title <- map["title"]
        self.link <- map["link"]
        self.image <- map["image"]
        self.lprice <- map["lprice"]
        self.hprice <- map["hprice"]
        self.mallName <- map["mallName"]
        self.productId <- map["productId"]
        self.productType <- map["productType"]
    }
}

struct FavoriteItems: Mappable {
    
    var title: String?
    var link: String?
    var image: String?
    var hprice: String?
    var lprice: String?
    var mallName: String?
    var isSelected = false

    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        self.title <- map["title"]
        self.link <- map["link"]
        self.image <- map["image"]
        self.hprice <- map["hprice"]
        self.lprice <- map["lprice"]
        self.mallName <- map["mallName"]
    }
    
    
}



