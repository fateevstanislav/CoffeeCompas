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

class CoffeeShop { // }: Codable, FireDataRepresentable {
    
    let name: String
    let address: String
    let logo: UIImage
    var phone: String = ""
    var email: String = ""
    var website: String = ""
    var comments: [Comment] = []
    var id: Int
    
    static var path: String {
       return "coffeeshops"
    }
    
    var fireId: String!
    
//    func encode(toChild child: DatabaseReference) {
//
//    }
    
//    static func decode(fromSnapshot snapshot: DataSnapshot) -> Self? {
//        guard let values = snapshot.value as? [String:Any] else {return nil}
//        let address = values[CodingKeys.address.stringvalue] as! String
//        let name =
//    }
    
    init(name: String, address: String, logo: UIImage, phone: String, email: String, id: Int) {
        self.name = name
        self.address = address
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
