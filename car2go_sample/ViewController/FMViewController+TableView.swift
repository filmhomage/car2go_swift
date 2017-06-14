//
//  FMViewController+TableView.swift
//  car2go_sample
//
//  Created by Jonghyun Kim on 2017/06/14.
//  Copyright © 2017 kokaru. All rights reserved.
//

import UIKit

extension FMViewController : UITableViewDelegate, UITableViewDataSource {
    
    func updateTableView(array : [Vehicle]?) {
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let vehicle = self.arrayVehicles {
            return vehicle.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : FMTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FMTableViewCell") as! FMTableViewCell
        cell.configureCell(vehicle: (self.arrayVehicles?[indexPath.row])!, index: indexPath.row)
        return cell
    }
}
