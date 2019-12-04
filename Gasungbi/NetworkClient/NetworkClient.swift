//
//  NetworkClient.swift
//  Gasungbi
//
//  Created by 강선미 on 23/11/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation

struct NetworkClient: NetworkClientProtocol {

    static let shared: NetworkClient = NetworkClient()

    private init() {}

    func createGetRequest(
        withUrl baseUrl: URL,
        headers: [String : String]?,
        completionHandler: @escaping (Data?, Error?) -> Void
    ) -> URLSessionDataTask {
        guard let urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false) else { preconditionFailure("Failed to Build URLComponents from: \(baseUrl)") }

        var urlRequest = URLRequest(url: urlComponents.url!)
        
        let ClientID = "YaRtVe3njeHDoaI5TIwg"
        let ClientSecret = "cacuTTxDDY"
        
        urlRequest.httpMethod = HTTPMethods.get

        if let headers = headers {
            headers.forEach { (key, value) in
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        } else {
            
            urlRequest.addValue(ClientID,forHTTPHeaderField: "X-Naver-Client-Id")
            urlRequest.addValue(ClientSecret,forHTTPHeaderField: "X-Naver-Client-Secret")
            
        } 

        return URLSession.shared.dataTask(with: urlRequest){ (data, urlResponse, error) in
            guard let data = data, error == nil else {
                completionHandler(nil, error)
                return
            }
            
            // data print
            let str = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) ?? ""
           // print(str)
            
            completionHandler(data, nil)
        }
    }
}
