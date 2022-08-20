//
//  Picture.swift
//  Challenge4
//
//  Created by Melody Davis on 8/20/22.
//

import Foundation

class Picture: NSObject, Codable {
    var name: String
    var caption: String
    
    init(name: String, caption: String) {
        self.name = name
        self.caption = caption
    }
}
