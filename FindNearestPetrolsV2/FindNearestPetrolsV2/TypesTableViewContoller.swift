//
//  TypesTableViewContoller.swift
//  FindNearestPetrolsV2
//
//  Created by Dushko Cizaloski on 10/27/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//"bakery":"Bakery", "bar":"Bar", "cafe":"Cafe", "grocery_or_supermarket":"Supermarket", "restaurant":"Restaurant",

import Foundation
import UIKit

protocol TypesTableViewControllerDelegate: class {
  func typesController(_ controller: TypesTableViewController, didSelectTypes types: [String])
}

class TypesTableViewController: UITableViewController {
  
  let possibleTypesDictionary = [ "gas_station":"Gas_Sation"]
  var selectedTypes: [String]!
  weak var delegate: TypesTableViewControllerDelegate!
  var sortedKeys: [String] {
    return possibleTypesDictionary.keys.sorted()
  }
  
  // MARK: - Actions
//  @IBAction func donePressed(_ sender: AnyObject) {
//    delegate?.typesController(self, didSelectTypes: selectedTypes)
//  }
  @IBAction func donePress(_ sender: Any) {
     delegate?.typesController(self, didSelectTypes: selectedTypes)  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return possibleTypesDictionary.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCell", for: indexPath)
    let key = sortedKeys[indexPath.row]
    let type = possibleTypesDictionary[key]!
    cell.textLabel?.text = type
    cell.imageView?.image = UIImage(named: key)
    cell.accessoryType = (selectedTypes!).contains(key) ? .checkmark : .none
    
    return cell
  }
  
  // MARK: - Table view delegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let key = sortedKeys[indexPath.row]
    if (selectedTypes!).contains(key) {
      selectedTypes = selectedTypes.filter({$0 != key})
    } else {
      selectedTypes.append(key)
    }
    
    tableView.reloadData()
  }
}
