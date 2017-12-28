//
//  RateViewController.swift
//  CoffeeСompas
//
//  Created by student on 27.12.2017.
//  Copyright © 2017 com.sfedu.sinigr. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RateViewController: UIViewController {

    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var comment: UITextView!
    
    var coffeeShopRef: DatabaseReference?
    var coffeeShop: CoffeeShop?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func sendTouched(_ sender: Any) {
        let user = Auth.auth().currentUser
        let username = user != nil ? (user?.displayName)! : "anonymous"
        let cmnt = Comment(text: comment.text, username: username, rating: rating.rating)
        cmnt.encode(toChild: (coffeeShopRef?.child("comments").childByAutoId())!)
        //coffeeShop?.comments.append(cmnt)
        //CoffeeShopTableViewController.updateCSData()
        
        if let vc = navigationController?.popViewController(animated: true) {
            vc.dismiss(animated: false)
        } else {
            self.dismiss(animated: true)
        }
    }
    
}
