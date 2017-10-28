//
//  PlaceMarker.swift
//  FindNearestPetrolsV2
//
//  Created by Dushko Cizaloski on 10/27/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
class PlaceMarker: GMSMarker {
  let place: GooglePlace
  
  init(place: GooglePlace) {
    self.place = place
    super.init()
    
    position = place.coordinate
    icon = UIImage(named: place.placeType+"_pin")
    
    groundAnchor = CGPoint(x: 0.5, y: 1)
    appearAnimation = kGMSMarkerAnimationPop
  }
}
