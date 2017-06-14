//
//  Const.swift
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/06/14.
//  Copyright © 2017 kokaru. All rights reserved.
//

import UIKit

struct Const {

// "https://www.car2go.com/api/v2.1/operationareas?oauth_consumer_key=consumer_key&loc=Berlin&format=json"
// "https://www.car2go.com/api/v2.1/locations?oauth_consumer_key=consumer_key&format=json"
// "https://www.car2go.com/api/v2.1/parkingspots?loc=Berlin&oauth_consumer_key=consumer_key&format=json"
// "https://www.car2go.com/api/v2.1/gasstations?loc=Berlin&oauth_consumer_key=consumer_key&format=json"
// "https://www.car2go.com/api/v2.1/vehicles?loc=Berlin&oauth_consumer_key=consumer_key&format=json"
    
    static let BASE_URL     = "https://www.car2go.com/api/v2.1/"
    static let API_VEHICLES = "vehicles"
    
    static let FMThemeColor      = UIColor.init(colorLiteralRed: 31.0/255.0, green: 179.0/255.0, blue: 248.0/255.0, alpha: 1.0)
    static let FMThemeColorAlpha = UIColor.init(colorLiteralRed: 31.0/255.0, green: 179.0/255.0, blue: 248.0/255.0, alpha: 0.5)
    static let FMMapLineColor    = UIColor.init(colorLiteralRed: 255.0/255.0, green: 38.0/255.0, blue:   0.0/255.0, alpha: 1.0)
}
