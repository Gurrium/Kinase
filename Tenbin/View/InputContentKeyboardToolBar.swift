//
//  InputContentToolBar.swift
//  Tanbin
//
//  Created by Taira Kaneko on 2019/06/09.
//  Copyright © 2019 Taira Kaneko. All rights reserved.
//

import UIKit

protocol InputContentKeyboardToolBarDelegate {
    func doneButtonTapped(on toolBar: InputContentKeyboardToolBar)
    func nextButtonTapped(on toolBar: InputContentKeyboardToolBar)
    func prevButtonTapped(on toolBar: InputContentKeyboardToolBar)
}

class InputContentKeyboardToolBar: UIToolbar {
    let doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped(on:)))
        return button
    }()
    let nextButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: ">", style: .plain, target: self, action: #selector(nextButtonTapped(on:)))
        return button
    }()
    let prevButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(prevButtonTapped(on:)))
        return button
    }()
    let space: UIBarButtonItem = {
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        return space
    }()
    
    var keyboardToolBarDelegate: InputContentKeyboardToolBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    func setupViews() {
        self.setItems([space, prevButton, nextButton, doneButton], animated: false)
    }
    
    @objc func doneButtonTapped(on toolBar: InputContentKeyboardToolBar) {
        keyboardToolBarDelegate?.doneButtonTapped(on: toolBar)
    }
    
    @objc func nextButtonTapped(on toolBar: InputContentKeyboardToolBar) {
        keyboardToolBarDelegate?.nextButtonTapped(on: toolBar)
    }
    
    @objc func prevButtonTapped(on toolBar: InputContentKeyboardToolBar) {
        keyboardToolBarDelegate?.prevButtonTapped(on: toolBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
