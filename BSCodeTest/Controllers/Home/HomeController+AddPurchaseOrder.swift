//
//  HomeController+AddPurchaseOrder.swift
//  BSCodeTest
//
//  Created by Hanisa Mohamed on 16/11/20.
//

import UIKit

extension HomeController: AddPurchaseOrderControllerDelegate {
    
    func didAddPurchaseOrder(purchaseOrder: PurchaseOrder) {
        
        purchaseOrders.append(purchaseOrder)
        
        let newIndexPath = IndexPath(row: purchaseOrders.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
}
