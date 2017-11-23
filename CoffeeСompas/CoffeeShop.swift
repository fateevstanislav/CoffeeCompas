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
    var rating: Double = 0
    var website: String = ""
    var comments: [Comment] = []
    
    
    init(name: String, logo: UIImage, phone: String, email: String) {
        self.name = name
        self.logo = logo
        self.email = email
        self.phone = phone
    }
}
