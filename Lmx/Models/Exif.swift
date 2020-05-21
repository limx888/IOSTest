//
//  Exif.swift
//  Lmx
//
//  Created by Lmx on 2019/4/12.
//  Copyright © 2019 Lmx. All rights reserved.
//

import Foundation

struct Exif {
    let createTime: String
    let width: Int
    let height: Int
    let make: String
    let model: String
    let aperture: String
    let exposureTime: String
    let focalLength: String
    let iso: Int
    
    init(createTime: String,
         width: Int, height: Int,
         make: String,
         model: String,
         aperture: String,
         exposureTime: String,
         focalLength: String,
         iso: Int) {
        self.createTime = createTime
        self.width = width
        self.height = height
        self.make = make
        self.model = model
        self.aperture = aperture
        self.exposureTime = exposureTime
        self.focalLength = focalLength
        self.iso = iso
    }
}
