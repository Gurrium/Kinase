//
//  ViewController.swift
//  Tanbin
//
//  Created by Taira Kaneko on 2019/06/06.
//  Copyright © 2019 Taira Kaneko. All rights reserved.
//

import UIKit
import SwiftIconFont

class ContentViewController: UIViewController, ContentDataPassingDelegate {
    var items: [Item] = [] {
        didSet {
            contentsTableView.reloadData()
        }
    }
    
    let contentsTableFooterView: UITableViewHeaderFooterView = {
        let footerView = UITableViewHeaderFooterView(frame: .zero)
        return footerView
    }()
    let contentsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        return tableView
    }()
    let addContentButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.icon(from: .fontAwesome, ofSize: 34.0)
        button.setTitle(String.fontAwesomeIcon("plus"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .init(hexString: "3d6cb9")
        return button
    }()
    let clearAllContentsButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.icon(from: .fontAwesome, ofSize: 34.0)
        button.setTitle(String.fontAwesomeIcon("bomb"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .init(hexString: "e43a19")
        return button
    }()
    let controlButtonsContainer: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        contentsTableView.dataSource = self
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(contentsTableView)
        contentsTableView.tableFooterView = contentsTableFooterView
        contentsTableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        contentsTableView.register(ContentsTableViewCell.self, forCellReuseIdentifier: "content")
        
        setupButtons()
    }
    
    fileprivate func setupButtons() {
        let buttonRadius = view.bounds.width / 5
        
        view.addSubview(controlButtonsContainer)
        controlButtonsContainer.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: view.bounds.width / 15), size: .init(width: buttonRadius, height: buttonRadius * 2.1))
        
        controlButtonsContainer.addSubview(addContentButton)
        addContentButton.anchor(top: nil, leading: controlButtonsContainer.leadingAnchor, bottom: controlButtonsContainer.bottomAnchor, trailing: controlButtonsContainer.trailingAnchor, size: .init(width: buttonRadius, height: buttonRadius))
        addContentButton.layer.cornerRadius = buttonRadius * 0.5
        let addContentRecognizer = UITapGestureRecognizer(target: self, action: #selector(addButtonTapped(_:)))
        addContentButton.addGestureRecognizer(addContentRecognizer)

        controlButtonsContainer.addSubview(clearAllContentsButton)
        clearAllContentsButton.anchor(top: controlButtonsContainer.topAnchor, leading: controlButtonsContainer.leadingAnchor, bottom: nil, trailing: controlButtonsContainer.trailingAnchor, size: .init(width: buttonRadius, height: buttonRadius))
        clearAllContentsButton.layer.cornerRadius = buttonRadius * 0.5
        let clearAllContentsRecognizer = UITapGestureRecognizer(target: self, action: #selector(clearAllContentsButtonTapped(_:)))
        clearAllContentsButton.addGestureRecognizer(clearAllContentsRecognizer)
    }
    
    @objc func addButtonTapped(_ sender: UIView) {
        let nextViewController: AddNewContentViewController = AddNewContentViewController()
        nextViewController.delegate = self
        self.present(nextViewController, animated: true)
    }
    
    @objc func clearAllContentsButtonTapped(_ sender: UIView) {
        items.removeAll()
    }
    
    func updateData(_ addNewContentViewController: AddNewContentViewController, item: Item) {
        items.insert(item, at: 0)
        items.sort(by: { (first, second) in
            let firstRatio = Float(first.price) / first.net
            let secondRatio = Float(second.price) / second.net
            return firstRatio < secondRatio
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ContentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "content", for: indexPath) as? ContentsTableViewCell else {
            return ContentsTableViewCell()
        }
        let item = items[indexPath.item]
        cell.price = item.price
        cell.net = item.net
        return cell
    }
}
