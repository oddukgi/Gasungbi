//
//  NetworkClientProtocol.swift
//  Gasungbi
//
//  Created by 강선미 on 23/11/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation

protocol NetworkClientProtocol {
    func createGetRequest(withUrl baseUrl: URL, headers: [String: String]?,
                          completionHandler: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask
}
