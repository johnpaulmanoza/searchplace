//
//  City.swift
//  Lemi
//
//  Created by John Paul Manoza on 20/03/2020.
//  Copyright © 2020 John Paul Manoza. All rights reserved.
//

import Foundation
import ObjectMapper

class City: Mappable {
    var cityName:       String?
    var citySubTitle:   String?
    var cityBanner:     String?
    var cityColor:      String?
    var cityCode:       String?
    
    required init?(map: Map){

    }
    
    func mapping(map: Map) {
        cityName        <- map["name"]
        citySubTitle    <- map["subtitle"]
        cityBanner      <- map["banner"]
        cityColor       <- map["color"]
        cityCode        <- map["country_code"]
    }
}
