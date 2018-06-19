//
//  ViewController.swift
//  gameofchat
//
//  Created by MAC on 4/29/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

final class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchHomeFeed { (homeFeed) in
            print(homeFeed.user)
            homeFeed.videos.forEach({print($0)})
        }
    }
    
    fileprivate func fetchHomeFeed(completion: @escaping (HomeFeed) -> ()) {
        let urlString = "https://api.letsbuildthatapp.com/youtube/home_feed"
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            guard let data = data else { return }
            do {
                let homeFeed = try JSONDecoder().decode(HomeFeed.self, from: data)
                completion(homeFeed)
            } catch let jsonErr {
                print("Failed to decode json:", jsonErr)
            }
        }.resume()
    }
}
