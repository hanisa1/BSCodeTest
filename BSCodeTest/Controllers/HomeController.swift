//
//  ViewController.swift
//  BSCodeTest
//
//  Created by Hanisa Mohamed on 13/11/20.
//

import UIKit
import CoreData

class HomeController: UITableViewController, AddPurchaseOrderControllerDelegate {
    
    
    let cellID = "cellID"
    
    var purchaseOrders = [PurchaseOrder]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        setupNavigationStyle()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView()
        
        fetchPurchaseOrders()
    }
    
    fileprivate func fetchPurchaseOrders() {
        //Core Data fetch
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<PurchaseOrder>(entityName: "PurchaseOrder")
        
        do {
            let purchaseOrders = try context.fetch(fetchRequest)
            purchaseOrders.forEach({ (pOrder) in
                print(pOrder.poID ?? "")
            })
            
            self.purchaseOrders = purchaseOrders
            self.tableView.reloadData()
            
        } catch let fetchErr {
            print("Failed to fetch purchase orders: ", fetchErr)
        }
        
        
        
    }

    func didAddPurchaseOrder(purchaseOrder: PurchaseOrder) {
        
        purchaseOrders.append(purchaseOrder)
        
        let newIndexPath = IndexPath(row: purchaseOrders.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    fileprivate func setupNavigationStyle() {
        navigationItem.title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let plusImageConfig = UIImage.SymbolConfiguration(pointSize: 140)
        
        let plusImage = UIImage(systemName: "plus.circle.fill", withConfiguration: plusImageConfig)
        let plusBarButtonItem = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(handleAddPO))
        plusBarButtonItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: -80)
        
        navigationItem.rightBarButtonItem = plusBarButtonItem
    }
    
    @objc fileprivate func handleAddPO() {
        print("Adding Purchase Order...")
        
        // Creating AddPurchaseOrderController
        let addPurchaseOrderController = AddPurchaseOrderController()
        let navController = UINavigationController(rootViewController: addPurchaseOrderController)
        
        addPurchaseOrderController.delegate = self
        present(navController, animated: true)
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

