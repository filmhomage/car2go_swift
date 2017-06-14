//
//  FMPinAnnotationView.swift
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/06/14.
//  Copyright © 2017 kokaru. All rights reserved.
//

import UIKit
import MapKit

class FMPinAnnotationView: MKAnnotationView {

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.canShowCallout = true
        self.rightCalloutAccessoryView = UIButton.init(type: .detailDisclosure)
        self.image = UIImage.init(named: "car2go_with_text")
        
        let viewLeftAccessory : UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: self.frame.size.height, height: self.frame.size.height))
        let imageView = UIImageView.init(frame: CGRect(x: 5, y: 3, width: self.frame.size.height-10, height: self.frame.size.height-10))
        imageView.image = UIImage(named: "car")
        imageView.contentMode = .scaleAspectFit
        viewLeftAccessory.addSubview(imageView)
        self.leftCalloutAccessoryView = viewLeftAccessory
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
