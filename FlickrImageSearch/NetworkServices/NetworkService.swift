//
//  NetworkService.swift
//  FlickrImageSearch
//
//  Created by Jahan on 19/11/2024.
//

import UIKit

class NetworkService {
    
    let BASE_URL = "https://api.flickr.com/services/feeds/photos_public.gne?format=json"
    func fetchPhotos(searchText: String, completion: @escaping (FlickrResponse?) -> Void) {
        let tags = searchText.replacingOccurrences(of: ",", with: "&").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = BASE_URL + "&nojsoncallback=1&tags=\(tags)"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            do {
                let decoder = JSONDecoder()
                let photosResponse = try decoder.decode(FlickrResponse.self, from: data)
                completion(photosResponse)
            } catch {
                completion(nil)
            }
        }.resume()
    }
}
