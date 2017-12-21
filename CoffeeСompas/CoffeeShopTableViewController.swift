//
//  CoffeeShopTableViewController.swift
//  CoffeeСompas
//
//  Created by student on 15.11.2017.
//  Copyright © 2017 com.sfedu.sinigr. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CoffeeShopTableViewController: UITableViewController, FirebaseDataDelegate {

    // MARK: Properties
    
    var fireSourceRef: DatabaseReference!
    var fireObservers = NSMutableDictionary()
    
    var coffeeShops = [CoffeeShop]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fireSourceRef = FireWrapper.data.userData.root.child("coffeeshops")
        let cshops = fireSourceRef.load(with: self.loadCoffeeShops(withSnapshot: ))
        loadSampleCoffeShops()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func loadCoffeeShops(withSnapshot snapshot: DataSnapshot) {
        
        for child in snapshot.children {
            print("\n\n======================\n\n")
            print(child)
            print("\n\n======================\n\n")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffeeShops.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CoffeeShopTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CoffeShopTableViewCell else {
            fatalError("The dequeued cell is not an instance of \(cellIdentifier).")
        }
        let coffeeShop = coffeeShops[indexPath.row]
        
        cell.nameLabel.text = coffeeShop.name
        cell.photoImageView.image = coffeeShop.logo
        cell.ratingControl.rating = coffeeShop.rating()
        

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showCoffeeShopInfo" {
            let dest  = (segue.destination as? CoffeeShopViewController);
            dest?.coffeeShop = coffeeShops[self.tableView.indexPathForSelectedRow!.row]
        }
    }
    
    // Mark: Private Methods
    
    private func loadSampleCoffeShops() {
        let photo1 = UIImage(named: "starbucks")
        let photo2 = UIImage(named: "pitcoffee")
        
        let user1 = CoffeeShopUser(name: "Barry Allen")
        let user2 = CoffeeShopUser(name: "Wally West")
        
        let comment1 = Comment(text: "Good", author: user1, rating: 5, coffeeShopId: 1)
        let comment2 = Comment(text: "Not so bad", author: user1, rating: 4, coffeeShopId: 1)
        let comment3 = Comment(text: "Delicious coffee, nothing unusual", author: user2, rating: 4, coffeeShopId: 2)
        let comment4 = Comment(text: "Nice coffee shop", author: user2, rating: 4, coffeeShopId: 2)
        
        let cs1 = CoffeeShop(name: "Starbucks", logo: photo1!, phone: "12345", email: "email@email", id: 1)
        cs1.comments = [comment1, comment3]
        let cs2 = CoffeeShop(name: "Пить кофе", logo: photo2!, phone: "12345", email: "email@email", id: 2)
        cs2.comments = [comment2, comment4]
        
        coffeeShops += [cs1, cs2]
    }

}
