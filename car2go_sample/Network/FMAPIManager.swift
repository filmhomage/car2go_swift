//
//  FMAPIManager.swift
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/06/14.
//  Copyright © 2017 kokaru. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class FMAPIManager {
    
    static let sharedInstance = FMAPIManager()

    func vehiclesAPI(completion: @escaping ([Vehicle]?) -> Void) {
        
        // FIXME: As a developer you must register as a so called "consumer" at car2go. See registration for more details.
        // About oauth_consumer_key, check to https://github.com/car2go/openAPI/wiki/Access-protected-Functions-via-OAuth-1.0
        let URL = Const.BASE_URL + Const.API_VEHICLES + "?loc=Berlin&oauth_consumer_key=oauth_consumer_key&format=json"
        Alamofire.request(URL).responseObject { (response: DataResponse<Placemarks>) in
            
            guard response.result.isSuccess else {
                print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                completion(nil)
                return
            }
            if let placemark = response.result.value, let vehicles = placemark.vehicle {
                completion(vehicles)
            }
        }
    }
}
