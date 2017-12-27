//
//  CoffeeShopTableViewController.swift
//  CoffeeСompas
//
//  Created by student on 15.11.2017.
//  Copyright © 2017 com.sfedu.sinigr. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorageUI

class CoffeeShopTableViewController: UITableViewController, FirebaseDataDelegate {

    // MARK: Properties
    
    var fireSourceRef: DatabaseReference!
    var fireObservers = NSMutableDictionary()
    
    var coffeeShops = [CoffeeShop]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fireSourceRef = FireWrapper.data.userData.root.child(CoffeeShop.path)
        fireSourceRef.load(with: self.loadCoffeeShops(withSnapshot: ))
    }
    
    func loadCoffeeShops(withSnapshot snapshot: DataSnapshot) {
        
        var css = [CoffeeShop]()
        
        for child in snapshot.children {
            if let cs = CoffeeShop.decode(fromSnapshot: child as! DataSnapshot) {
                css.append(cs)
            }
        }
        
        coffeeShops = css
        tableView.reloadData()
        refreshControl?.endRefreshing()
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
        cell.ratingControl.rating = coffeeShop.rating()
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let imgRef = storageRef.child(coffeeShop.logo_url)
        let placeholderImage = UIImage(named: "placeholder.jpg")
        cell.imageView?.sd_setImage(with: imgRef, placeholderImage: placeholderImage)

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

}
