//
//  NetworkService.swift
//  TestProject
//
//  Created by emil kurbanov on 13.05.2024.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func loadAPI(completion: @escaping ([Photo]) -> Void) {
        var photos: [Photo] = []
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.unsplash.com"
        urlComponents.path = "/photos"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "bQSSBuCWh_NnKo0RjZNdVxoaIiYdQy2cVjAEFAHM3pQ"),
        ]
        guard let url = urlComponents.url else {
            completion([])
            return
        }
        
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                print("json: \(json)")
                for item in json.arrayValue {
                    
                    let description = item["alt_description"].string
                    let user = item["user"]
                    let userName = user["name"].string ?? "Unknown"
                    let totalPhoto = user["total_photos"].intValue
                    let links = item["links"]
                    
                    guard let photoURLString = links["download"].string,
                          let photoURL = URL(string: photoURLString) else {
                        continue
                    }
                    
                    let photo = Photo(userName: userName, imageURL: photoURL, totalPhoto: totalPhoto, description: description ?? "")
                    photos.append(photo)
                }
                completion(photos)
                
            case .failure(let error):
                print("Error loading API: \(error)")
                completion([])
            }
        }
    }
}

