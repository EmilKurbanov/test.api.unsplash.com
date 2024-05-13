//
//  Photo.swift
//  TestProject
//
//  Created by emil kurbanov on 13.05.2024.
//

import UIKit

struct Photo: Decodable, Hashable {
        let userName: String
        let imageURL: URL
        let totalPhoto: Int
        let description: String
    }
