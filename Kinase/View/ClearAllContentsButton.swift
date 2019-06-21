//
//  AllClearButton.swift
//  Kinase
//
//  Created by Taira Kaneko on 2019/06/20.
//  Copyright © 2019 Taira Kaneko. All rights reserved.
//

import UIKit
import SwiftIconFont

class ClearAllContentsButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)

        setTitle(String.fontAwesomeIcon("bomb"), for: .normal)
        setTitleColor(.white, for: .normal)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
