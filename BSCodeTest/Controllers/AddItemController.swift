//
//  AddItemController.swift
//  BSCodeTest
//
//  Created by Hanisa Mohamed on 17/11/20.
//

import UIKit

class AddItemController: UIViewController {

    let itemIDLabel: UILabel = {
        let label = UILabel()
        label.text = "Purchase Order ID :"
        //enable autolayout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let itemIdTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Purchase Order ID"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "No. of Items :"
        //enable autolayout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let quantityTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Item Amount"
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
        navigationItem.title = "Add Item"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSaveItem))
    }
    
    fileprivate func setupUI() {
        view.addSubview(itemIDLabel)
        itemIDLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        itemIDLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        itemIDLabel.widthAnchor.constraint(equalToConstant: 170).isActive = true
        itemIDLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        itemIDLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        
        view.addSubview(itemIdTextField)
        itemIdTextField.leftAnchor.constraint(equalTo: itemIDLabel.rightAnchor).isActive = true
        itemIdTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        itemIdTextField.bottomAnchor.constraint(equalTo: itemIDLabel.bottomAnchor).isActive = true
        itemIdTextField.topAnchor.constraint(equalTo: itemIDLabel.topAnchor).isActive = true
        
        view.addSubview(quantityLabel)
        quantityLabel.topAnchor.constraint(equalTo: itemIDLabel.bottomAnchor).isActive = true
        quantityLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        quantityLabel.widthAnchor.constraint(equalToConstant: 170).isActive = true
        quantityLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        quantityLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        
        view.addSubview(quantityTextField)
        quantityTextField.leftAnchor.constraint(equalTo: quantityLabel.rightAnchor).isActive = true
        quantityTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        quantityTextField.bottomAnchor.constraint(equalTo: quantityLabel.bottomAnchor).isActive = true
        quantityTextField.topAnchor.constraint(equalTo: itemIdTextField.bottomAnchor).isActive = true
    }
    
    @objc fileprivate func handleSaveItem() {
        print("Saving Item.")
        
        guard let itemID = itemIdTextField.text else { return }
        guard let quantity = quantityTextField.text else { return }
        
        let error = CoreDataManager.shared.addItem(itemID: itemID, quantity: quantity)
        if let error = error {
            print(error)
        } else {
            dismiss(animated: true)
        }
        
        
    }

}
