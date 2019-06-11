//
//  AddNewContentViewController.swift
//  Kinase
//
//  Created by Taira Kaneko on 2019/06/09.
//  Copyright © 2019 Taira Kaneko. All rights reserved.
//

import UIKit

protocol ContentDataPassingDelegate {
    func updateData(_ addNewContentViewController: AddNewContentViewController, item: Item)
}

class AddNewContentViewController: UIViewController {
    let keyboardToolBar: InputContentKeyboardToolBar = {
        let toolBar = InputContentKeyboardToolBar(frame: .zero)
        toolBar.sizeToFit()
        return toolBar
    }()
    let priceTextField: UITextField = {
        let textField = UITextField(frame: .init(x: 0, y: 0, width: 0, height: 50))
        textField.keyboardType = .numberPad
        textField.placeholder = "値段"
        return textField
    }()
    let netTextField: UITextField = {
        let textField = UITextField(frame: .init(x: 0, y: 0, width: 0, height: 50))
        textField.keyboardType = .numberPad
        textField.placeholder = "内容量"
        return textField
    }()
    let doneInputButton: UIButton = {
        let button = UIButton(type: .system)
        // TODO アイコン変える
        button.setTitle("○", for: .normal)
        return button
    }()
    let cancelInputButton: UIButton = {
        let button = UIButton(type: .system)
        // TODO アイコン変える
        button.setTitle("×", for: .normal)
        return button
    }()
    
    var delegate: ContentDataPassingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        keyboardToolBar.keyboardToolBarDelegate = self
        
        let closeKeyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(closeKeyboardRecognizer)
        
        doneInputButton.addTarget(self, action: #selector(doneInputButtonTapped), for: .touchUpInside)
        cancelInputButton.addTarget(self, action: #selector(cancelInputButtonTapped), for: .touchUpInside)
        
        setupNotifications()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        priceTextField.becomeFirstResponder()
    }
    
    @objc func doneInputButtonTapped() {
        guard let price_text = priceTextField.text, let net_text = netTextField.text else {
            return
        }
        guard let price = Int(price_text) else {
            return
        }
        guard let net = Float(net_text) else {
            return
        }
        
        let item = Item(price: price, net: net)
        
        delegate?.updateData(self, item: item)
        backToContentViewController()
    }
    
    @objc func cancelInputButtonTapped() {
        backToContentViewController()
    }
    
    func backToContentViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func closeKeyboard() {
        view.endEditing(false)
    }
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let rect = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        
        UIView.animate(withDuration: duration, animations: {
            let translation = CGAffineTransform(translationX: 0, y: -rect.size.height / 2)
            self.priceTextField.transform = translation
            self.netTextField.transform = translation
        })
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        
        UIView.animate(withDuration: duration, animations: {
            let translation = CGAffineTransform.identity
            self.priceTextField.transform = translation
            self.netTextField.transform = translation
        })
    }
    
    func setupViews() {
        priceTextField.inputAccessoryView = keyboardToolBar
        netTextField.inputAccessoryView = keyboardToolBar
        
        view.addSubview(priceTextField)
        view.addSubview(netTextField)
        priceTextField.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.centerYAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 10, right: 10))
        netTextField.anchor(top: view.centerYAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        
        view.addSubview(doneInputButton)
        view.addSubview(cancelInputButton)
        doneInputButton.anchor(top: nil, leading: view.centerXAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0))
        cancelInputButton.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.centerXAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 10))
    }
}

extension AddNewContentViewController: InputContentKeyboardToolBarDelegate {
    func doneButtonTapped(on toolBar: InputContentKeyboardToolBar) {
        closeKeyboard()
    }
    
    func nextButtonTapped(on toolBar: InputContentKeyboardToolBar) {
        netTextField.becomeFirstResponder()
    }
    
    func prevButtonTapped(on toolBar: InputContentKeyboardToolBar) {
        priceTextField.becomeFirstResponder()
    }
}
