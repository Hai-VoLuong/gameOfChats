//
//  BaseTableViewController.swift
//  gameofchat
//
//  Created by MAC on 7/3/18.
//  Copyright © 2018 MAC. All rights reserved.
//


import UIKit

class BaseCell<U>: UITableViewCell {
    
    var item: U!
}

class BaseTableViewController<T: BaseCell<U>, U>: UITableViewController {
    
    let cellId = "cellId"
    
    var items = [U]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(T.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BaseCell<U>
        cell.item = items[indexPath.row]
        return cell
    }
    
}

// ===================== TestDogController ===============================
struct Dog {
    let name: String
}

class DogCell: BaseCell<Dog> {
    
    override var item: Dog! {
        didSet {
            textLabel?.text = item.name
        }
    }
}

class TestDogController: BaseTableViewController<DogCell, Dog> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items = [
            Dog(name: "Woof Woof"),
            Dog(name: "Ruff Ruff Ruff")
        ]
    }
}

// ===================== TestStringController ================================

class StringCell: BaseCell<String> {
    
    override var item: String! {
        didSet {
            textLabel?.text = item
        }
    }
}

class TestStringController: BaseTableViewController<StringCell, String> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items = ["Woof Woof", "Ruff Ruff Ruff"]
    }
}
