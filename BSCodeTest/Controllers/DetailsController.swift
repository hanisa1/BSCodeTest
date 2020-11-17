//
//  DetailsController.swift
//  BSCodeTest
//
//  Created by Hanisa Mohamed on 14/11/20.
//

import UIKit
import CoreData

class DetailsController: UITableViewController {

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
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let request = NSFetchRequest<Item>(entityName: "Item")
        
        do {
            let items = try context.fetch(request)
            self.items = items
            
        } catch let err {
            print("Failed to fetch items: ", err)
        }
        
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
        let navController = UINavigationController(rootViewController: addItemOrderController)
        present(navController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ItemHeaderView()
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellItemID, for: indexPath)
        let item = items[indexPath.row]
        
        if let itemID = item.itemID, let quantity = item.quantity {
            cell.textLabel?.text = "ItemID: \(itemID)   Quantity: \(quantity)"
        } else {
            cell.textLabel?.text = "ItemID: Unknown   Quantity: Unknown"
        }
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}
