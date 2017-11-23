//
//  CoffeShop.swift
//  CoffeeСompas
//
//  Created by student on 09.11.2017.
//  Copyright © 2017 com.sfedu.sinigr. All rights reserved.
//

import Foundation
import UIKit

class User {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

class Comment {
    let text: String
    let author: User
    let rating: Double
    
    
    init(text: String, author: User, rating: Double) {
        self.text = text
        self.author = author
        self.rating = rating
    }
}

class CoffeeShop {
    let name: String
    let logo: UIImage
    var phone: String = ""
    var email: String = ""
    var website: String = ""
    var comments: [Comment] = []
    
    init(name: String, logo: UIImage, phone: String, email: String) {
        self.name = name
        self.logo = logo
        self.email = email
        self.phone = phone
    }
    
    func rating() -> Double {
        if comments.count == 0 {
            return 0.0
        }
        let sumOfRatings = comments.reduce(0.0) { ($0 + ($1.rating)) }
        return sumOfRatings / Double(comments.count)
    }
}
