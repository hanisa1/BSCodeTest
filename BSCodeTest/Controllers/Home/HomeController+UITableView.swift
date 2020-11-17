//
//  HomeController+UITableView.swift
//  BSCodeTest
//
//  Created by Hanisa Mohamed on 16/11/20.
//

import UIKit

extension HomeController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsController = DetailsController()
        navigationController?.pushViewController(detailsController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let purchaseOrder = purchaseOrders[indexPath.row]
        if let poId = purchaseOrder.poID, let items = purchaseOrder.noItems, let updated = purchaseOrder.lastUpdated {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            dateFormatter.locale = Locale(identifier: "en_US")
            let formattedUpdate = dateFormatter.string(from: updated)
            
            cell.textLabel?.text = "PoID: \(poId)   ItemNo: \(items)   \(formattedUpdate)"
        } else {
            cell.textLabel?.text = "ID: Unknown - ItemNo: 0 - Updated: Unknown"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchaseOrders.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HomeHeaderView()
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}
