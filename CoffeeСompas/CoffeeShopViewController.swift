//
//  CoffeeShopViewController.swift
//  CoffeeСompas
//
//  Created by student on 09.11.2017.
//  Copyright © 2017 com.sfedu.sinigr. All rights reserved.
//

import UIKit

class CoffeeShopViewController: UIViewController, UITextFieldDelegate,
  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var coffeeShop: CoffeeShop?
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var changeRating: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCoffeeShop()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadCoffeeShop()
    {
        logo.image = coffeeShop?.logo
        name.text = coffeeShop?.name
        address.text = coffeeShop?.website
        email.text = coffeeShop?.email
        phone.text = coffeeShop?.phone
        rating.rating = (coffeeShop?.rating)!
    }


}

