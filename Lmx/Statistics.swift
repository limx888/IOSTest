//
//  Statistics.swift
//  Lmx
//
//  Created by Lmx on 2019/4/12.
//  Copyright © 2019 Lmx. All rights reserved.
//

import Foundation

struct Statistics {
    let downloads: Int
    let views: Int
    let likes: Int
    
    init(downloads: Int, views: Int, likes: Int) {
        self.downloads = downloads
        self.views = views
        self.likes = likes
    }
}
