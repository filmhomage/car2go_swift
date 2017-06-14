//
//  Placemarks.swift
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/06/14.
//  Copyright © 2017 kokaru. All rights reserved.
//

import ObjectMapper

class Placemarks: Mappable {
    
    var vehicle : [Vehicle]?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        vehicle <- map["placemarks"]
    }
}

