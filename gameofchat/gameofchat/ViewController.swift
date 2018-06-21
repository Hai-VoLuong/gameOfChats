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
        
//        fetchGenericData(urlString: "https://api.letsbuildthatapp.com/youtube/home_feed") { (homeFeed: HomeFeed) in
//            homeFeed.videos.forEach({print($0)})
//        }
//
//        fetchGenericData(urlString: "https://api.letsbuildthatapp.com/youtube/course_detail?id=1" ) { (courseDetails: [CourseDetail]) in
//            courseDetails.forEach({print($0.name, $0.duration)})
//        }
        
        struct Course: Decodable {
            let id: Int
            let name: String
            let link: String
        }
        fetchGenericData(urlString: "https://api.letsbuildthatapp.com/jsondecodable/courses") { (courses: [Course]) in
            courses.forEach({print($0.link)})
        }
    }
    
    fileprivate func fetchGenericData<T: Decodable>(urlString: String, completion: @escaping (T) -> ()) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            
            if let err = err {
                print("Failed to fetch data:", err)
                return
            }
            
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
