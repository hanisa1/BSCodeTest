//
//  addPurchaseOrderController.swift
//  BSCodeTest
//
//  Created by Hanisa Mohamed on 15/11/20.
//

import UIKit

class AddPurchaseOrderController: UIViewController {

    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        //enable autolayout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
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
    }

    fileprivate func setupUI() {
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        nameLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
    }

}
