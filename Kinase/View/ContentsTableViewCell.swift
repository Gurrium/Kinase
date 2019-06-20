//
//  HistoryViewCell.swift
//  Kinase
//
//  Created by Taira Kaneko on 2019/06/07.
//  Copyright © 2019 Taira Kaneko. All rights reserved.
//

import UIKit

class ContentsTableViewCell: UITableViewCell {
    var price: Int = 0 {
        didSet {
            updateLabel()
        }
    }
    var net: Float = 0.0 {
        didSet {
            updateLabel()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func updateLabel() {
        textLabel?.text = formulaText()
    }
    
    func formulaText() -> String {
        return "\(price) / \(Int(net)) = \(Float(self.price) / net)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
