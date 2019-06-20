//
//  AddContentButton.swift
//  Kinase
//
//  Created by Taira Kaneko on 2019/06/11.
//  Copyright © 2019 Taira Kaneko. All rights reserved.
//

import UIKit

class AddContentButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setTitle("+", for: .normal)
        layer.borderColor = UIColor.systemBlue.cgColor
        layer.borderWidth = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
