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
    var selectedIndex = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(toolBar)
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.allowsSelection = false
        fillToolBar()
                
        layout()
    }
    
    func layout() {
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        toolBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        toolBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        toolBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: toolBar.topAnchor).isActive = true
    }
    
    func fillToolBar() {
        let add = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addItem))
        
        let remove = UIBarButtonItem(image: UIImage(systemName: "minus"), style: .plain, target: self, action: #selector(removeItem))
        
        let move = UIBarButtonItem(image: UIImage(systemName: "bonjour"), style: .plain, target: self, action: #selector(moveItem))
        
        let reload = UIBarButtonItem(image: UIImage(systemName: "arrow.3.trianglepath"), style: .plain, target: self, action: #selector(reloadItem))
        
        toolBar.setItems([add, remove, move, reload], animated: false)
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
    
    @objc func reloadItem() {
        rowCount = 50
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: rowCount - 1, section: 0), at: .bottom, animated: false)
    }
    
    @objc func moveItem() {
        let oldIndexPath = IndexPath(row: selectedIndex, section: 0)
        
        var startFrame: CGRect?
        var finishFrame: CGRect?
        
        if let cell = tableView.cellForRow(at: oldIndexPath) {
            cell.imageView?.image = UIImage(systemName: "circle")
            cell.imageView?.tintColor = .clear
            startFrame = cell.convert(cell.imageView!.frame, to: tableView)
        }
        selectedIndex = (0 ..< rowCount).randomElement() ?? -1
        
        let newIndexPath = IndexPath(row: selectedIndex, section: 0)
        let finishCell: UITableViewCell?
        if let cell = tableView.cellForRow(at: newIndexPath) {
            finishFrame = cell.convert(cell.imageView!.frame, to: tableView)
            finishCell = cell
        } else {
            finishCell = nil
        }
        
        guard let startFrame, let finishFrame else { return }
        let movingView = UIImageView(image: UIImage(systemName: "tram.circle"))
        movingView.frame = startFrame
        movingView.tintColor = .red
        tableView.addSubview(movingView)
        UIView.animate(withDuration: 3, delay: 0) {
            movingView.frame = finishFrame
        } completion: { _ in
            finishCell?.imageView?.image = UIImage(systemName: "tram.circle")
            finishCell?.imageView?.tintColor = .red
            movingView.removeFromSuperview()
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
        if indexPath.row == selectedIndex {
            cell.imageView?.image = UIImage(systemName: "tram.circle")
            cell.imageView?.tintColor = .red
        } else {
            cell.imageView?.image = UIImage(systemName: "circle")
            cell.imageView?.tintColor = .clear
        }
        return cell
    }
}


