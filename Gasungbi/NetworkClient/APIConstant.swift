//
//  APIConstant.swift
//  Gasungbi
//
//  Created by 강선미 on 27/11/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation

class APIConstant: APIConstantProtocol {
 
     static let shared: APIConstant = APIConstant()
     private init() {}
    
     func url(_ keyword: String) -> String {
       //               return Endpoints.base + "/search/movie" + Endpoints.apiKeyParam + "&query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""))"
        return "https://openapi.naver.com/v1/search/shop.json" + "?query=\(keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")" + "&start=1&display=10&sort=sim"
    }
    
}
