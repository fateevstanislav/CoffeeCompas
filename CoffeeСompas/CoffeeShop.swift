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
import FirebaseStorageUI
import MapKit

class CoffeeShopUser {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

struct Comment : Codable {
    let text: String
    //let author: CoffeeShopUser
    let username: String
    let rating: Double
    //let coffeeShopId: Int
    
    init(text: String, username: String, rating: Double) {
        self.text = text
        self.username = username
        self.rating = rating
        //self.coffeeShopId = coffeeShopId
    }
    
    static func decode(fromSnapshot snapshot: DataSnapshot) -> Comment? {
        guard let values = snapshot.value as? [String:Any] else {return nil}
        let text = values[CodingKeys.text.stringValue] as! String
        let username = values[CodingKeys.username.stringValue] as! String
        let rating = Double(values[CodingKeys.rating.stringValue] as! String)
        
        return Comment(text: text, username: username, rating: rating!)
    }
    
    func Rating() -> Double {
        return Double(self.rating)
    }
    
    func encode(toChild child: DatabaseReference) {
        child.setValue([CodingKeys.text.stringValue: text,
                        CodingKeys.username.stringValue: username,
                        CodingKeys.rating.stringValue: String(rating)])
    }
}

struct CoffeeShop : Codable, FireDataRepresentable {
    
    let name: String
    let address: String
    let logo_url: String
    var phone: String = ""
    var email: String = ""
    var website: String = ""
    var comments: [Comment] = []
    let latitude: Double
    let longitude: Double
    
    static var path: String {
       return "coffeeshops"
    }
    
    var fireId: String!
    
    func encode(toChild child: DatabaseReference) {
        child.setValue([CodingKeys.name.stringValue: name,
                        CodingKeys.address.stringValue: address,
                        CodingKeys.logo_url.stringValue: logo_url,
                        CodingKeys.phone.stringValue: phone,
                        CodingKeys.email.stringValue: email,
                        CodingKeys.website.stringValue: website,
                        CodingKeys.latitude.stringValue: String(latitude),
                        CodingKeys.longitude.stringValue: String(longitude)])
        for c in comments {
            c.encode(toChild: child.child(CodingKeys.comments.stringValue).childByAutoId())
        }
    }
    
    static func decode(fromSnapshot snapshot: DataSnapshot) -> CoffeeShop? {
        guard let values = snapshot.value as? [String:Any] else {return nil}
        let address = values[CodingKeys.address.stringValue] as! String
        let name = values[CodingKeys.name.stringValue] as! String
        let logo_url = values[CodingKeys.logo_url.stringValue] as! String
        let phone = values[CodingKeys.phone.stringValue] as! String
        let email = values[CodingKeys.email.stringValue] as! String
        let website = values[CodingKeys.website.stringValue] as! String
        let latitude = values[CodingKeys.latitude.stringValue] as! Double
        let longitude = values[CodingKeys.longitude.stringValue] as! Double
        var comments: [Comment] = []
        for comment in snapshot.childSnapshot(forPath: "comments").children {
            comments.append(Comment.decode(fromSnapshot: comment as! DataSnapshot)!)
        }
        
        var cs = CoffeeShop(name: name, address: address, logo_url: logo_url, website: website, phone: phone, email: email, latitude: latitude, longitude: longitude)
        cs.comments = comments
        return cs
    }
    
    init(name: String, address: String, logo_url: String, website: String, phone: String, email: String, latitude: Double, longitude: Double) {
        self.name = name
        self.address = address
        self.logo_url = logo_url
        self.website = website
        self.email = email
        self.phone = phone
        self.latitude = latitude
        self.longitude = longitude
        //self.id = id
    }
    
    func rating() -> Double {
        if comments.count == 0 {
            return 0.0
        }
        let sumOfRatings = comments.reduce(0.0) { ($0 + ($1.Rating())) }
        return sumOfRatings / Double(comments.count)
    }
}

class CoffeeShopAnnotation: NSObject, MKAnnotation {
    let coffeeShop: CoffeeShop
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(coffeeShop: CoffeeShop) {
        self.coffeeShop = coffeeShop
        self.coordinate = CLLocationCoordinate2D(latitude: coffeeShop.latitude, longitude: coffeeShop.longitude)
        self.title = coffeeShop.name
    }
}
