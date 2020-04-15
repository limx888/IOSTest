//
//  Photo.swift
//  Lmx
//
//  Created by Lmx on 2019/4/12.
//  Copyright © 2019 Lmx. All rights reserved.
//

struct Photo {
    let id: String
    let imageURL: String
    let profileImageURL: String
    let name: String
    let userName: String
    var isLike: Bool
    var heartCount: Int
    let bio: String
    let location: String
    let portfolioURL: String
    
    init(id: String,
         imageURL: String,
         profileImageURL: String,
         name: String,
         userName: String,
         isLike: Bool,
         heartCount: Int,
         bio: String,
         location: String,
         portfolioURL: String) {
        self.id = id
        self.imageURL = imageURL
        self.profileImageURL = profileImageURL
        self.name = name
        self.userName = userName
        self.isLike = isLike
        self.heartCount = heartCount
        self.bio = bio
        self.location = location
        self.portfolioURL = portfolioURL
    }
}
