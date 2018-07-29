//
//  ViewController2TableViewController.swift
//  gameofchat
//
//  Created by MAC on 7/29/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class ViewController2: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }

    @objc func handleLogout() {
        
    }
}
