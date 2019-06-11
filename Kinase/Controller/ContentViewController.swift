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
    
    let historyTableFooterView: HistoryTableFooterView = {
        let footerView = HistoryTableFooterView(frame: .init(x: 0, y: 0, width: 0, height: 50))
        return footerView
    }()
    let historyTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        historyTableView.dataSource = self
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(historyTableView)
        let addHistoryRecognizer = UITapGestureRecognizer(target: self, action: #selector(addButtonTapped(_:)))
        historyTableFooterView.tapHandler.addGestureRecognizer(addHistoryRecognizer)
        historyTableView.tableFooterView = historyTableFooterView
        historyTableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        historyTableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: "history")
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
