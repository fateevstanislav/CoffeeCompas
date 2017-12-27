//
//  CoffeeShopViewController.swift
//  CoffeeСompas
//
//  Created by student on 09.11.2017.
//  Copyright © 2017 com.sfedu.sinigr. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorageUI

class CoffeeShopViewController: UIViewController, UITextFieldDelegate,
UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var coffeeShop: CoffeeShop?
    var comments: [Comment] = []
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var changeRating: UIButton!
    @IBOutlet weak var website: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCoffeeShop()
        //comments = (coffeeShop?.comments)!
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func loadCoffeeShop()
    {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let imgRef = storageRef.child((coffeeShop?.logo_url)!)
        let placeholderImage = UIImage(named: "placeholder.jpg")
        logo.sd_setImage(with: imgRef, placeholderImage: placeholderImage)
        name.text = coffeeShop?.name
        address.text = coffeeShop?.address
        email.text = coffeeShop?.email
        website.text = coffeeShop?.website
        phone.text = coffeeShop?.phone
        rating.rating = (coffeeShop?.rating())!
        comments = (coffeeShop?.comments)!
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CommentTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CommentTableViewCell else {
            fatalError("The dequeued cell is not an instance of \(cellIdentifier).")
        }
        let comment = comments[indexPath.row]
        
        cell.nameLabel.text = comment.username
        cell.rating.rating = comment.rating
        cell.textLabel?.text = comment.text
        
        return cell
    }


}

