//
//  NaverClient+Constants.swift
//  Gasungbi
//
//  Created by 강선미 on 24/11/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import Foundation

extension NaverClient {
    //Flicker API Constants
    enum API {
        static let BaseUrl = "https://api.flickr.com/services/rest/"
    }

    enum Methods {
        static let PhotosSearch = "flickr.photos.search"
    }

    enum ParameterKeys {
        static let APIKey = "api_key"
        static let Method = "method"
        static let Format = "format"
        static let NoJsonCallback = "nojsoncallback"
        static let Text = "text"
        static let Extra = "extras"
        static let Latitude = "lat"
        static let Longitude = "lon"
        static let Radius = "radius"
        static let RadiusUnits = "radius_units"
        static let Page = "page"
        static let ResultsPerPage = "per_page"
        static let Sort = "sort"
    }

    enum ParameterDefaultValues {
        static let Format = "json"
        static let NoJsonCallback = "1"
        static let ExtraMediumURL = "url_m"
        static let ResultsPerPage = "50"
        static let Radius = "0.1"
        static let RadiusUnits = "km"
        static let APIKey = "0a7e1179f73468f0ba09d3e87c1241f7" // ADD YOUR FLICKR API KEY HERE
        static let Sort = "date-posted-desc"
    }
}
