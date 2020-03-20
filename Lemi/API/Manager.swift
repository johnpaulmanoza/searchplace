//
//  Manager.swift
//  Lemi
//
//  Created by John Paul Manoza on 20/03/2020.
//  Copyright © 2020 John Paul Manoza. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import RxSwift

class APIManager {
    
    func loadCities(query: String? = nil) -> Observable<Any> {
        var url = "https://lemi.travel/api/v5/cities"
        
        // append query if available
        if let q = query {
            url.append("?q=\(q)")
        }
        
        return Observable<Any>.create { observer in
            // request
            Alamofire.request(url).responseArray { (response: DataResponse<[City]>) in
                guard let cities = response.value else { observer.onCompleted(); return }
                observer.onNext(cities); observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
}
