//
//  MapPointAnnotation.swift
//  FindNearestPetrolsV2
//
//  Created by Dushko Cizaloski on 9/27/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import Foundation
import MapKit
import UIKit
class MapPointAnnotation: NSObject, MKAnnotation
{
  var coordinate: CLLocationCoordinate2D

  var name: String?
  var address: String?
  var title: String?
  var subtitle: String?
  init(name: String?, address: String?,cooridinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
    self.name = name
    self.address = address
    self.coordinate = cooridinate
    self.title = title
    self.subtitle = subtitle
    
    super.init()
  }
  var myCoordinate: CLLocationCoordinate2D {
    return coordinate
  }
  var placeTitle: String{
    return title!
  }
  var placeSubtitle: String {
    return subtitle!
  }
}
