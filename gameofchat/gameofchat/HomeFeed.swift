//
//  HomeFeed.swift
//  gameofchat
//
//  Created by MAC on 6/19/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import Foundation

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
