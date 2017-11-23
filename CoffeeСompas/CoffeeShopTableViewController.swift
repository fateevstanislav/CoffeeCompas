//
//  CoffeeShopTableViewController.swift
//  CoffeeСompas
//
//  Created by student on 15.11.2017.
//  Copyright © 2017 com.sfedu.sinigr. All rights reserved.
//

import UIKit

class CoffeeShopTableViewController: UITableViewController {

    // MARK: Properties
    
    var coffeeShops = [CoffeeShop]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleCoffeShops()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        cell.ratingControl.rating = coffeeShop.rating
        

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

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
        
        let cs1 = CoffeeShop(name: "Starbucks", logo: photo1!, phone: "12345", email: "email@email")
        cs1.rating = 4.75
        let cs2 = CoffeeShop(name: "Пить кофе", logo: photo2!, phone: "12345", email: "email@email")
        cs2.rating = 3.5
        
        coffeeShops += [cs1, cs2]
    }

}
