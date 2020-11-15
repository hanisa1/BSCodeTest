//
//  addPurchaseOrderController.swift
//  BSCodeTest
//
//  Created by Hanisa Mohamed on 15/11/20.
//

import UIKit
import CoreData

protocol AddPurchaseOrderControllerDelegate {
    func didAddPurchaseOrder(purchaseOrder: PurchaseOrder)
}

class AddPurchaseOrderController: UIViewController {
    
    var delegate: AddPurchaseOrderControllerDelegate?
    
    let purchaseOrderIDLabel: UILabel = {
        let label = UILabel()
        label.text = "Purchase Order ID :"
        //enable autolayout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let poIdTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Purchase Order ID"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .secondarySystemBackground
        setupNavigationBarStyle()
        setupUI()
    }
    
    fileprivate func setupNavigationBarStyle() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Add Purchase Order"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }

    fileprivate func setupUI() {
        view.addSubview(purchaseOrderIDLabel)
        purchaseOrderIDLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        purchaseOrderIDLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        purchaseOrderIDLabel.widthAnchor.constraint(equalToConstant: 170).isActive = true
//        purchaseOrderIDLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        purchaseOrderIDLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        purchaseOrderIDLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        
        view.addSubview(poIdTextField)
        poIdTextField.leftAnchor.constraint(equalTo: purchaseOrderIDLabel.rightAnchor).isActive = true
        poIdTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        poIdTextField.bottomAnchor.constraint(equalTo: purchaseOrderIDLabel.bottomAnchor).isActive = true
        poIdTextField.topAnchor.constraint(equalTo: purchaseOrderIDLabel.topAnchor).isActive = true
        
    }
    
    @objc fileprivate func handleSave() {
        print("Saving Purchase Order")
        dismiss(animated: true)
        
        //Initialisation of Core Data Stack
        
        let persistentContainer = NSPersistentContainer(name: "BSCodeTest")
        persistentContainer.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of Store Failed: \(err)")
            }
        }
        
        let context = persistentContainer.viewContext
        
        let purchaseOrder = NSEntityDescription.insertNewObject(forEntityName: "PurchaseOrder", into: context)
        purchaseOrder.setValue(poIdTextField.text, forKey: "poID")
        
        //Preform the save
        do {
            try context.save()
            
        } catch let saveErr {
            print("Failed to save Purchase Order: ", saveErr)
        }
        
        
        
        guard let poId = poIdTextField.text else { return }
        
//        let purchaseOrder = PurchaseOrder(poID: poId, noOfItems: 4, lastUpdated: Date())
//        
//        delegate?.didAddPurchaseOrder(purchaseOrder: purchaseOrder)
//        
    }

}
