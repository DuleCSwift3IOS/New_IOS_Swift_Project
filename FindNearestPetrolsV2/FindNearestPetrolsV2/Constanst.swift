//
//  Constanst.swift
//  FindNearestPetrolsV2
//
//  Created by Dushko Cizaloski on 9/26/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import Foundation
let API_KEY = "AIzaSyBO4Yw0C1myqpBr2az-XTg-R4y4U8iBnPM"
//var DISPATCH_QUEUE_PRIORITY_HIGH: Int32 { get }
let API_BASE_URL = "https:maps.googleapis.com/maps/api/place/search/json?location=enterUserLocationLat, enterUserLocationLon&radius=enterRadius&types=enterSomeTypeOfObject&sensor=true&key=API_KEY"
struct Google {

  let APIScheme = "https"
  let APIHost = "maps.googleapis.com"
  let APIPath = "/maps/api"
  
}
struct GoogleAPIValues
{
  let Method = ""
  let API_KEY = ""
  
  
}
/*
 struct FlickrParameterKeys {
 static let Method = "method"
 static let APIKey = "api_key"
 static let GalleryID = "gallery_id"
 static let Extras = "extras"
 static let Format = "format"
 static let NoJSONCallback = "nojsoncallback"
 static let SafeSearch = "safe_search"
 static let Text = "text"
 static let BoundingBox = "bbox"
 static let Page = "page"
 }
 */
