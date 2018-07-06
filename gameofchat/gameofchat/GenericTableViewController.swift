//
//  GenericTableViewController.swift
//  gameofchat
//
//  Created by MAC on 7/3/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class GenericCell<U>: UITableViewCell {
    
    var item: U!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

class GenericTableViewController<T: GenericCell<U>, U>: UITableViewController {
    
    let cellId = "id"
    
    var items = [U]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(T.self, forCellReuseIdentifier: cellId)
        
        tableView.tableFooterView = UIView()
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.refreshControl = rc
    }
    
    @objc func handleRefresh() {
        tableView.refreshControl?.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! GenericCell<U>
        cell.item = items[indexPath.row]
        return cell
    }
}

// ========================== SomeListController =====================================

class TextCell: GenericCell<String> {
    
    override var item: String! {
        didSet {
            textLabel?.text = item
        }
    }
}

class SomeListController: GenericTableViewController<TextCell, String> {
    
    override var items: [String] {
        get {
            return ["TEST", "HELLO", "THIRD"]
        }
        set {
            self.items = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let accountVC = AccountController()
        navigationController?.pushViewController(accountVC, animated: true)
    }

    @objc func handleNext() {
        navigationController?.pushViewController(AccountController(), animated: true)
    }
}

// ======================== VideosController =======================================
struct Account {
    
    let id: Int
    let name: String
}

class AccountCell: GenericCell<Account> {
    
    override var item: Account! {
        didSet {
            textLabel?.text = item.name
        }
    }
}

class AccountController: GenericTableViewController<AccountCell, Account> {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Fetching Movies"
        DispatchQueue.global(qos: .background).async {
            Thread.sleep(forTimeInterval: 2)
            DispatchQueue.main.async { [weak self] in
                guard let this = self else { return }
                this.items = [
                    Account(id: 1, name: "Steve Jobs: The Movie")
                ]
                this.navigationItem.title = "Done"
                this.tableView.reloadData()
            }
        }
    }
}

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [SomeListController()]
    }
}
