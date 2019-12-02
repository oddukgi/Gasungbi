//
//  APIManager.swift
//  Gasungbi
//
//  Created by 강선미 on 27/11/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation

import Alamofire
import AlamofireObjectMapper

// MARK: - APIManager
class APIManager: APIConstant {
   
       // MARK: - SearchResultsGroup
       // MARK: Methods
    
    static func search(item: String, _ completion: @escaping (DataResponse<SearchResultsGroup>) -> Void) {        let urlString: String = APIConstant.shared.url(item)
           
           let header = ["X-Naver-Client-Id":"YaRtVe3njeHDoaI5TIwg",
                         "X-Naver-Client-Secret":"cacuTTxDDY"]
           
           Alamofire.request(urlString, headers: header).validate(statusCode: 200 ..< 500).responseObject { (response: DataResponse<SearchResultsGroup>) in
                         switch response.result {
                         case .success:
                             completion(response)
                             
                         case .failure(let error):
                             print("Failed Request [getRepoData] - \(error)")
                         }
                     }
       }
       
       
//       static func getRepoData(repoURL: String, _ completion: @escaping (DataResponse<Repo>) -> Void) {
//
//
//        let header = ["X-Naver-Client-Id":"YaRtVe3njeHDoaI5TIwg",
//                      "X-Naver-Client-Secret":"cacuTTxDDY"]
//           let headers: HTTPHeaders = self.getAccessToken()
//
//           Alamofire.request(repoURL, headers: header).validate(statusCode: 200 ..< 500).responseObject { (response: DataResponse<Repo>) in
//               switch response.result {
//               case .success:
//                   completion(response)
//
//               case .failure(let error):
//                   print("Failed Request [getRepoData] - \(error)")
//               }
//           }
//       }



}
