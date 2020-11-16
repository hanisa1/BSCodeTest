//
//  ViewController.swift
//  BSCodeTest
//
//  Created by Hanisa Mohamed on 13/11/20.
//

import UIKit
import CoreData

class HomeController: UITableViewController {
    
    let cellID = "cellID"
    
    var purchaseOrders = [PurchaseOrder]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        setupNavigationStyle()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView()
        
        self.purchaseOrders = CoreDataManager.shared.fetchPurchaseOrders()
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
    
}

