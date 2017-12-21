//
//  CoffeShop.swift
//  CoffeeСompas
//
//  Created by student on 09.11.2017.
//  Copyright © 2017 com.sfedu.sinigr. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class CoffeeShopUser {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

class Comment {
    let text: String
    let author: CoffeeShopUser
    let rating: Double
    let coffeeShopId: Int
    
    init(text: String, author: CoffeeShopUser, rating: Double, coffeeShopId: Int) {
        self.text = text
        self.author = author
        self.rating = rating
        self.coffeeShopId = coffeeShopId
    }
}

class CoffeeShop { //}: FireDataRepresentable {
    //static var path: String {
    //    return "coffeeshops"
    //}
    
    //var fireId: String!
    
    //func encode(toChild child: DatabaseReference) {
    //    <#code#>
    //}
    
    //static func decode(fromSnapshot snapshot: DataSnapshot) -> Self? {
    //    <#code#>
    //}
    
    let name: String
    let logo: UIImage
    var phone: String = ""
    var email: String = ""
    var website: String = ""
    var comments: [Comment] = []
    public let id: Int
    
    init(name: String, logo: UIImage, phone: String, email: String, id: Int) {
        self.name = name
        self.logo = logo
        self.email = email
        self.phone = phone
        self.id = id
    }
    
    func rating() -> Double {
        if comments.count == 0 {
            return 0.0
        }
        let sumOfRatings = comments.reduce(0.0) { ($0 + ($1.rating)) }
        return sumOfRatings / Double(comments.count)
    }
}
