//
//  Media.swift
//  FlickrImageSearch
//
//  Created by Jahan on 19/11/2024.
//

import UIKit

struct FlickrMedia: Codable {
    let imageUrl: String // URL for the image
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "m"
    }
}
