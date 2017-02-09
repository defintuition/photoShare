//
//  CategoriesTableViewController.swift
//  Hipstagram
//
//  Created by Karen Fuentes on 2/6/17.
//  Copyright © 2017 Annie Tung. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    let arrayOfCategories = [("COFFEE", #imageLiteral(resourceName: "coffee")), ("ART",#imageLiteral(resourceName: "art")),("MUSIC", #imageLiteral(resourceName: "music")), ("FOOD",#imageLiteral(resourceName: "food")),("FASHION", #imageLiteral(resourceName: "fashion")), ("SCENARY",#imageLiteral(resourceName: "scenery")),("PETS",#imageLiteral(resourceName: "pets")),( "RANDOM", #imageLiteral(resourceName: "random"))]
    let identifier = "CategoriesCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: identifier)
        self.tableView.rowHeight = 220
        self.title = "CATEGORIES"
    }
    
    // MARK: - TableViewDataSource Methods 
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayOfCategories.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CategoriesTableViewCell
        cell.cellLabel.text = arrayOfCategories[indexPath.row].0
        cell.backgroundColor = .clear
        cell.cellImage.image = arrayOfCategories[indexPath.row].1
        return cell
    }
    
    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let nav = navigationController {
            let backItem = UIBarButtonItem()
            backItem.title = " "
            navigationItem.backBarButtonItem = backItem
            
            let detailController = DetailCategoryCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
            detailController.categorySelectedName = arrayOfCategories[indexPath.row].0
            detailController.categorySelectedImage = arrayOfCategories[indexPath.row].1
            nav.pushViewController(detailController, animated: true)
        }
    }
}
