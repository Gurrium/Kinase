//
//  ViewController.swift
//  Kinase
//
//  Created by Taira Kaneko on 2019/06/06.
//  Copyright © 2019 Taira Kaneko. All rights reserved.
//

import UIKit

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
    let addContentButton: AddContentButton = {
        let button = AddContentButton(type: .system)
        return button
    }()
    let clearAllContentsButton: ClearAllContentsButton = {
        let button = ClearAllContentsButton(type: .system)
        return button
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
        
        view.addSubview(addContentButton)
        addContentButton.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 20, right: 40), size: .init(width: view.frame.width / 5, height: view.frame.width / 5))
        addContentButton.layer.cornerRadius = 0.5 * addContentButton.constraints[0].constant
        let buttonFontSize = addContentButton.constraints[1].constant * 0.5
        addContentButton.titleLabel?.font = UIFont.icon(from: .fontAwesome, ofSize: buttonFontSize)
        let addContentRecognizer = UITapGestureRecognizer(target: self, action: #selector(addButtonTapped(_:)))
        addContentButton.addGestureRecognizer(addContentRecognizer)
        
        view.addSubview(clearAllContentsButton)
        clearAllContentsButton.anchor(top: nil, leading: nil, bottom: addContentButton.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 20, right: 40), size: .init(width: view.frame.width / 5, height: view.frame.width / 5))
        clearAllContentsButton.layer.cornerRadius = 0.5 * clearAllContentsButton.constraints[0].constant
        clearAllContentsButton.titleLabel?.font = UIFont.icon(from: .fontAwesome, ofSize: buttonFontSize)
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
