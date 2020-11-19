//
//  DetailsController.swift
//  BSCodeTest
//
//  Created by Hanisa Mohamed on 14/11/20.
//

import UIKit
import CoreData

class DetailsController: UITableViewController, AddItemControllerDelegate {
    
    func didAddItem(item: Item) {
        items.append(item)
        tableView.reloadData()
    }
    
    var purchaseOrder: PurchaseOrder?
    
    var items = [Item]()
    
    let cellItemID = "cellItemID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationStyle()
        tableView.backgroundColor = .secondarySystemBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellItemID)
        fetchitems()
    }
    
    fileprivate func fetchitems() {
        
        guard let purchaseOrderItems = purchaseOrder?.items?.allObjects as? [Item] else {return}
        self.items = purchaseOrderItems

    }
    
    fileprivate func setupNavigationStyle() {
        navigationItem.title = "Details"
        navigationController?.navigationBar.prefersLargeTitles = true
        let plusImageConfig = UIImage.SymbolConfiguration(pointSize: 140)
        
        let plusImage = UIImage(systemName: "plus.circle.fill", withConfiguration: plusImageConfig)
        let plusBarButtonItem = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(handleAddItem))
        plusBarButtonItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: -80)
        
        navigationItem.rightBarButtonItem = plusBarButtonItem
    }


    @objc fileprivate func handleAddItem() {
        print("Adding item.")
        let addItemOrderController = AddItemController()
        addItemOrderController.delegate = self
        addItemOrderController.purchaseOrder = purchaseOrder
        let navController = UINavigationController(rootViewController: addItemOrderController)
        present(navController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == 0){
            let itemView = ItemHeaderView()
            return itemView
        } else {
            let invoiceView = InvoiceHeaderView()
            return invoiceView
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellItemID, for: indexPath)
        let item = items[indexPath.row]
        
        
        
        if (indexPath.section == 0){
            //section for items
            if let itemID = item.itemID, let quantity = item.quantity {
                cell.textLabel?.text = "ItemID: \(itemID)   Quantity: \(quantity)"
            } else {
                cell.textLabel?.text = "ItemID: Unknown   Quantity: Unknown"
            }
            
        } else {
            //section for invoices. Hard coded in due to lack of time
            cell.textLabel?.text = "Invoice No: 101   Received Status: 1"
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0){
            //section for items
            return items.count
            
        } else {
            //section for invoices
            return 1
        }
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
