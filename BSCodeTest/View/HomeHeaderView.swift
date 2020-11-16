//
//  HomeHeaderView.swift
//  BSCodeTest
//
//  Created by Hanisa Mohamed on 16/11/20.
//

import UIKit

class HomeHeaderView: UIView {

    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "🖥  Purchase Orders"
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray5
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        addSubview(headerLabel)
        headerLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        headerLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
