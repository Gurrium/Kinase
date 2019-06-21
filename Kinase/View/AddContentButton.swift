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
        
        setTitle(String.fontAwesomeIcon("plus"), for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = .init(hexString: "3d6cb9")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
