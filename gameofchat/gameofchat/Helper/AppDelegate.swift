//
//  AppDelegate.swift
//  gameofchat
//
//  Created by MAC on 4/29/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: ViewController2())
        return true
    }
    
    // Model / ViewModel
    struct Person {
        let firstName, lastName: String
    }
    
    // View
    class PersonCell: GenericCell<Person> {
        override var item: Person! {
            didSet {
                textLabel?.text = "\(item.firstName) \(item.lastName)"
            }
        }
    }
    
    // Controller
    class PeopleController: GenericTableViewController<PersonCell, Person> {
        override func viewDidLoad() {
            super.viewDidLoad()
            items = [Person(firstName: "Bill", lastName: "Clinton"),
                     Person(firstName: "Barack", lastName: "Obama"),
                     Person(firstName: "Donald", lastName: "Trump")
            ]
        }
    }
}

