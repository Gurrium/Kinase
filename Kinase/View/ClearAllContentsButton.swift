//
//  AllClearButton.swift
//  Kinase
//
//  Created by Taira Kaneko on 2019/06/20.
//  Copyright © 2019 Taira Kaneko. All rights reserved.
//

import UIKit

class ClearAllContentsButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setTitle("x", for: .normal)
        setTitleColor(.red, for: .normal)
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
