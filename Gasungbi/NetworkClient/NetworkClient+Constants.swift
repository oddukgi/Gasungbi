 //
//  NetworkCleint+Constants.swift
//  Gasungbi
//
//  Created by 강선미 on 23/11/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation
 
 extension NetworkClient {
     enum HeaderKeys {
         static let contentType = "Content-Type"
         static let accept = "Accept"
     }

     enum HeaderValues {
         static let contentType = "application/json"
         static let accept = "application/json"
     }

     enum HTTPMethods{
         static let get = "GET"
     }
 }
