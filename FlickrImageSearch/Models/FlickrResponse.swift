//
//  Untitled.swift
//  FlickrImageSearch
//
//  Created by Jahan on 19/11/2024.
//

import UIKit

struct FlickrResponse: Codable {
    let title: String
    let link: String
    let description: String
    let modified: String
    let generator: String
    let items: [FlickrItem]
}
