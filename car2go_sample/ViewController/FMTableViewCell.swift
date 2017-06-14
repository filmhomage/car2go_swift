//
//  FMTableViewCell.swift
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/06/14.
//  Copyright © 2017 kokaru. All rights reserved.
//

import UIKit

class FMTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelNumber: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelDistance: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var buttonFuel: UIButton!
    
    func configureCell(vehicle: Vehicle, index: Int) {
        
        self.selectedColor()
        self.labelAddress.text = vehicle.address
        self.labelName.text = vehicle.name
        self.labelNumber.text = "\(index + 1)"
        if let fuel = vehicle.fuel {
            self.buttonFuel.setTitle("\(String(describing: fuel))", for: .normal)
        }
        if let distance = vehicle.distance {
            self.labelDistance.text = distance >= 1000 ? "\(Int(distance / 1000))km" : "\(Int(distance))m"
        }
    }
    
    func selectedColor() {
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = Const.FMThemeColorAlpha
        self.selectedBackgroundView = bgColorView
    }
    
}
