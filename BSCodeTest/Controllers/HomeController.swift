//
//  ViewController.swift
//  BSCodeTest
//
//  Created by Hanisa Mohamed on 13/11/20.
//

import UIKit

class HomeController: UITableViewController {
    
    let cellID = "cellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        setupNavigationStyle()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView()
    }

    
    fileprivate func setupNavigationStyle() {
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let plusImageConfig = UIImage.SymbolConfiguration(pointSize: 140)
        
        let plusImage = UIImage(systemName: "plus.circle.fill", withConfiguration: plusImageConfig)
        let plusBarButtonItem = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(handleAddPO))
        plusBarButtonItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: -80)
        
        navigationItem.rightBarButtonItem = plusBarButtonItem
    }
    
    @objc fileprivate func handleAddPO() {
        print("Adding Purchase Order...")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = "Purchase Order"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

}

