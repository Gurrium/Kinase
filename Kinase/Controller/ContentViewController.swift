//
//  ViewController.swift
//  Kinase
//
//  Created by Taira Kaneko on 2019/06/06.
//  Copyright © 2019 Taira Kaneko. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController, ContentDataPassingDelegate {
    var items: [Item] = []
    
    let historyTableFooterView: UITableViewHeaderFooterView = {
        let footerView = UITableViewHeaderFooterView(frame: .zero)
        return footerView
    }()
    let historyTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()
    let addContentButton: AddContentButton = {
        let button = AddContentButton(type: .system)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        historyTableView.dataSource = self
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(historyTableView)
        historyTableView.tableFooterView = historyTableFooterView
        historyTableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        historyTableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: "history")
        
        view.addSubview(addContentButton)
        addContentButton.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 20, right: 40), size: .init(width: view.frame.width / 5, height: view.frame.width / 5))
        addContentButton.layer.cornerRadius = 0.5 * addContentButton.constraints[0].constant
        let fontSize = addContentButton.constraints[1].constant * 0.8
        addContentButton.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: .light)
        let addHistoryRecognizer = UITapGestureRecognizer(target: self, action: #selector(addButtonTapped(_:)))
        addContentButton.addGestureRecognizer(addHistoryRecognizer)
    }
    
    @objc func addButtonTapped(_ sender: UIView) {
        let nextViewController: AddNewContentViewController = AddNewContentViewController()
        nextViewController.delegate = self
        self.present(nextViewController, animated: true)
    }
    
    func updateData(_ addNewContentViewController: AddNewContentViewController, item: Item) {
        items.insert(item, at: 0)
        items.sort(by: { (first, second) in
            let firstRatio = Float(first.price) / first.net
            let secondRatio = Float(second.price) / second.net
            return firstRatio < secondRatio
        })
        historyTableView.reloadData()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "history", for: indexPath) as? HistoryTableViewCell else {
            return HistoryTableViewCell()
        }
        if indexPath.row == 0 {
            cell.backgroundColor = .green
        }
        let item = items[indexPath.item]
        cell.price = item.price
        cell.net = item.net
        return cell
    }
}
