//
//  Vehicle.swift
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/06/14.
//  Copyright © 2017 kokaru. All rights reserved.
//

import ObjectMapper

class Vehicle: Mappable {

    var address: String?
    var latitude: Double?
    var longitude: Double?
    var engineType: String?
    var exterior: String?
    var fuel: Int?
    var interior: String?
    var name: String?
    var smartPhoneRequired: Bool?
    var vin: String?
    var index: Int?
    var distance: Double?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        address <- map["address"]
        latitude <- map["coordinates.1.value"]
        longitude <- map["coordinates.0.value"]
        engineType <- map["engineType"]
        exterior <- map["exterior"]
        fuel <- map["fuel"]
        interior <- map["interior"]
        name <- map["name"]
        smartPhoneRequired <- map["smartPhoneRequired"]
        vin <- map["vin"]
    }
}
