//
//  ViewController.swift
//  PlayWithTable
//
//  Created by Alexey Golovenkov on 27.10.2022.
//

import UIKit

class ViewController: UIViewController {

    let toolBar = UIToolbar()
    let tableView = TableView()
    
    var rowCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(toolBar)
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        fillToolBar()
                
        layout()
    }
    
    func layout() {
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        toolBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        toolBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        toolBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        toolBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: toolBar.topAnchor).isActive = true
    }
    
    func fillToolBar() {
        let add = UIBarButtonItem(image: UIImage.init(systemName: "plus"), style: .plain, target: self, action: #selector(addItem))
        
        let remove = UIBarButtonItem(image: UIImage.init(systemName: "minus"), style: .plain, target: self, action: #selector(removeItem))
        toolBar.setItems([add, remove], animated: false)
    }
    
    @objc func addItem() {
        let index = IndexPath(row: rowCount, section: 0)
        rowCount += 1
        tableView.performBatchUpdates {
            tableView.insertRows(at: [index], with: .fade)
        }
    }
    
    @objc func removeItem() {
        guard rowCount > 0 else {
            return
        }        
        rowCount -= 1
        let index = IndexPath(row: rowCount, section: 0)
        tableView.performBatchUpdates {
            tableView.deleteRows(at: [index], with: .fade)
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Row #\(indexPath.row)"
        return cell
    }
}


