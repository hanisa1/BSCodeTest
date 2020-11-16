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
    
    let itemLabel: UILabel = {
        let label = UILabel()
        label.text = "No. of Items :"
        //enable autolayout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let itemTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Item Amount"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let lastUpdatedLabel: UILabel = {
        let label = UILabel()
        label.text = "Last Updated :"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
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
        // Laying out UI programmatically with constraints
        
        view.addSubview(purchaseOrderIDLabel)
        purchaseOrderIDLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        purchaseOrderIDLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        purchaseOrderIDLabel.widthAnchor.constraint(equalToConstant: 170).isActive = true
        purchaseOrderIDLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        purchaseOrderIDLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        
        view.addSubview(poIdTextField)
        poIdTextField.leftAnchor.constraint(equalTo: purchaseOrderIDLabel.rightAnchor).isActive = true
        poIdTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        poIdTextField.bottomAnchor.constraint(equalTo: purchaseOrderIDLabel.bottomAnchor).isActive = true
        poIdTextField.topAnchor.constraint(equalTo: purchaseOrderIDLabel.topAnchor).isActive = true
        
        view.addSubview(itemLabel)
        itemLabel.topAnchor.constraint(equalTo: purchaseOrderIDLabel.bottomAnchor).isActive = true
        itemLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        itemLabel.widthAnchor.constraint(equalToConstant: 170).isActive = true
        itemLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        itemLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        
        view.addSubview(itemTextField)
        itemTextField.leftAnchor.constraint(equalTo: itemLabel.rightAnchor).isActive = true
        itemTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        itemTextField.bottomAnchor.constraint(equalTo: itemLabel.bottomAnchor).isActive = true
        itemTextField.topAnchor.constraint(equalTo: poIdTextField.bottomAnchor).isActive = true
        
        view.addSubview(lastUpdatedLabel)
        lastUpdatedLabel.topAnchor.constraint(equalTo: itemLabel.bottomAnchor).isActive = true
        lastUpdatedLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        lastUpdatedLabel.widthAnchor.constraint(equalToConstant: 165).isActive = true
        lastUpdatedLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        lastUpdatedLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        
        view.addSubview(datePicker)
        datePicker.topAnchor.constraint(equalTo: itemTextField.bottomAnchor).isActive = true
        datePicker.leftAnchor.constraint(equalTo: lastUpdatedLabel.rightAnchor).isActive = true
        datePicker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        
    }
    
    @objc fileprivate func handleSave() {
        print("Saving Purchase Order")
        
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let purchaseOrder = NSEntityDescription.insertNewObject(forEntityName: "PurchaseOrder", into: context)
        purchaseOrder.setValue(poIdTextField.text, forKey: "poID")
        purchaseOrder.setValue(itemTextField.text, forKey: "noItems")
        purchaseOrder.setValue(datePicker.date, forKey: "lastUpdated")
        
        //Preform the save
        do {
            try context.save()
            
            //Success
            dismiss(animated: true) {
                self.delegate?.didAddPurchaseOrder(purchaseOrder: purchaseOrder as! PurchaseOrder)
            }
            
        } catch let saveErr {
            print("Failed to save Purchase Order: ", saveErr)
        }
        
        
        
//        guard let poId = poIdTextField.text else { return }
        
//        let purchaseOrder = PurchaseOrder(poID: poId, noOfItems: 4, lastUpdated: Date())
//        
//        delegate?.didAddPurchaseOrder(purchaseOrder: purchaseOrder)
//        
    }

}
