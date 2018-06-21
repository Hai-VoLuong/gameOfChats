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
        
//        fetchHomeFeed { (homeFeed) in
//            print(homeFeed.user)
//            homeFeed.videos.forEach({print($0)})
//        }
        
//        fetchDetails { (courseDetails) in
//            courseDetails.forEach({print($0.name, $0.duration)})
//        }
        
        fetchGenericData { (courseDetails: [CourseDetail]) in
            courseDetails.forEach({print($0.name, $0.duration)})
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
    
    fileprivate func fetchDetails(completion: @escaping ([CourseDetail]) -> ()) {
        let urlString = "https://api.letsbuildthatapp.com/youtube/course_detail?id=1"
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            
            guard let data = data else { return }
            
            do {
                let courseDetails = try JSONDecoder().decode([CourseDetail].self, from: data)
                completion(courseDetails)
            } catch let jsonErr {
                print("Failed to decode json:", jsonErr)
            }
            }.resume()
    }
    
    fileprivate func fetchGenericData<T: Decodable>(completion: @escaping (T) -> ()) {
        let urlString = "https://api.letsbuildthatapp.com/youtube/course_detail?id=1"
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            
            guard let data = data else { return }
            
            do {
                let obj = try JSONDecoder().decode(T.self, from: data)
                completion(obj)
            } catch let jsonErr {
                print("Failed to decode json:", jsonErr)
            }
            }.resume()
    }
}

struct CourseDetail: Decodable {
    let name: String
    let duration: String
}

struct HomeFeed: Decodable {
    let user: User
    let videos: [Video]
}

struct User: Decodable {
    let id: Int
    let name: String
    let username: String
}

struct Video: Decodable {
    let id: Int
    let name: String
    let link: String
    let imageUrl: String
    let numberOfViews: Double
    let channel: Channel
}

struct Channel: Decodable {
    let name: String
    let profileImageUrl: String
    let numberOfSubscribers: Double
}
