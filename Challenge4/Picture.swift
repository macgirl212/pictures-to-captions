//
//  Picture.swift
//  Challenge4
//
//  Created by Melody Davis on 8/20/22.
//

import Foundation

class Picture: NSObject, Codable {
    var image: URL
    var caption: String
    
    init(image: URL, caption: String) {
        self.image = image
        self.caption = caption
    }
}
