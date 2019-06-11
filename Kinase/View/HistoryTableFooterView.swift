//
//  HistoryViewCell.swift
//  Kinase
//
//  Created by Taira Kaneko on 2019/06/07.
//  Copyright © 2019 Taira Kaneko. All rights reserved.
//

import UIKit

class HistoryTableFooterView: UIView {
    let addButton: UIButton = {
        let button = UIButton.init(type: .contactAdd)
        button.tintColor = .blue
        button.sizeToFit()
        return button
    }()
    
    let tapHandler: UIView = {
        let view = UIView.init(frame: .zero)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    func setupViews() {
        self.addSubview(addButton)
        self.addSubview(tapHandler)
        tapHandler.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        addButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
