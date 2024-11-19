//
//  FlickrPhoto.swift
//  FlickrImageSearch
//
//  Created by Jahan on 19/11/2024.
//

import UIKit

struct FlickrItem: Codable, Identifiable {
    
    let id = UUID() // Unique identifier for SwiftUI
    let title: String
    let link: String
    let media: FlickrMedia
    let dateTaken: String
    let itemDescription: String
    let published: String
    let author: String
    let authorID: String
    let tags: String

    enum CodingKeys: String, CodingKey {
        case title, link, media, published, author, tags
        case dateTaken = "date_taken"
        case authorID = "author_id"
        case itemDescription = "description"
    }
}
