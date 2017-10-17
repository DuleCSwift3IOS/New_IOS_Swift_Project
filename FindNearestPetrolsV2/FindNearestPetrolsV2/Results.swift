//
//  Results.swift
//  FindNearestPetrolsV2
//
//  Created by Dushko Cizaloski on 10/15/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreLocation
class Results: NSObject, Mappable
{
  var name: String?
  var rating: Int?
  var vicinity: String?
  var geometry : [String: AnyObject]?
  var location: [String: AnyObject]?
  var latitude: CLLocationDegrees?
  var langitude: CLLocationDegrees?
  var cooridinates: CLLocationCoordinate2D?
  var image: String?
  
   init(jsonDic: NSDictionary) {
    self.name = jsonDic["name"] != nil ? jsonDic["name"] as! String! : nil
    self.vicinity = jsonDic["vicinity"] != nil ? jsonDic["vicinity"] as! String! : nil
    self.rating = jsonDic["rating"] != nil ? jsonDic["rating"] as! Int! : nil
    self.image = jsonDic["icon"] != nil ? jsonDic["icon"] as! String! : nil
    self.geometry = jsonDic["geometry"] != nil ? jsonDic["geometry"] as! [String: AnyObject]! : nil
    self.location = geometry?["location"] != nil ? geometry?["location"] as! [String: AnyObject]! : nil
    self.latitude = location?["lat"] != nil ? location?["lat"] as? CLLocationDegrees : nil
    self.langitude = location?["lng"] != nil ? location?["lng"] as? CLLocationDegrees : nil
    self.cooridinates = CLLocationCoordinate2D(latitude: latitude!, longitude: langitude!)
  }
  override init() {
    
  }
  
  required init?(map: Map) {
  }
  
  func mapping(map: Map) {
    name <- map["name"]
    rating <- map["rating"]
    vicinity <- map["vicinity"]
    geometry <- map["geometry"]
  }
}

class Location: NSObject, Mappable
{
  var location: [String: AnyObject]?
  
  init(jsonDic: NSDictionary) {
    self.location = jsonDic["location"] != nil ? jsonDic["location"] as! [String: AnyObject]! : nil
  }
  
  override init() {
    
  }
  
  required init?(map: Map) {
    
  }
  
  func mapping(map: Map) {
    location <- map["location"]
  }
}
