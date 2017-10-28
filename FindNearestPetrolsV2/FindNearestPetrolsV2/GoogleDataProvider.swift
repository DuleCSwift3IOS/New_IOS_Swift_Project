//
//  GoogleDataProvider.swift
//  FindNearestPetrolsV2
//
//  Created by Dushko Cizaloski on 10/27/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation
import SwiftyJSON
import Alamofire
class GoogleDataProvider {
  var photoCache = [String:UIImage]()
  var placesTask: URLSessionDataTask?
  var session: URLSession {
    return URLSession.shared
  }
  //prominence
  func fetchPlacesNearCoordinate(_ coordinate: CLLocationCoordinate2D, radius: Double, types:[String], completion: @escaping (([GooglePlace]) -> Void)) -> ()
  {
    var urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(coordinate.latitude),\(coordinate.longitude)&radius=\(radius)&rankby=prominence&sensor=true&key=\("AIzaSyBO4Yw0C1myqpBr2az-XTg-R4y4U8iBnPM")"
    let typesString = types.count > 0 ? types.joined(separator: "|") : ""
    urlString += "&types=\(typesString)"
    urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    var showURL = NSURL(string: urlString)
    print(showURL)
    if let task = placesTask, task.taskIdentifier > 0 && task.state == .running {
      task.cancel()
    }
    
    //    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    //    Alamofire.request(urlString).responseJSON{ (response) in
    //    let objJSON = response.result.value
    //      print(objJSON)
    //    }
    placesTask = session.dataTask(with: showURL! as! URL, completionHandler: {data, response, error in
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
      var placesArray = [GooglePlace]()
      
      if let dataFromString = data  {
        let json = JSON(data:dataFromString as Data, options:JSONSerialization.ReadingOptions.mutableContainers, error:nil)
        if let results = json["results"].arrayObject as? [[String: AnyObject]]{
          for rawPlace in results {
            let place = GooglePlace(dictionary: rawPlace, acceptedTypes: types)
            placesArray.append(place)
            if let reference = place.photoReference {
              self.fetchPhotoFromReference(reference) { image in
                place.photo = image
                
              }
            }
          }
        }
      }
      DispatchQueue.main.async {
        completion(placesArray)
      }
    })
    placesTask?.resume()
  }
  
  
  
  func fetchPhotoFromReference(_ reference: String, completion: @escaping ((UIImage?) -> Void)) -> () {
    if let photo = photoCache[reference] as UIImage? {
      completion(photo)
    } else {
      let urlString = "http://maps.googleapis.com/maps/api/place/photo?maxwidth=200&photoreference=\(reference)"
      UIApplication.shared.isNetworkActivityIndicatorVisible = true
      session.downloadTask(with: URL(string: urlString)!, completionHandler: {url, response, error in
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        if let url = url {
          let downloadedPhoto = UIImage(data: try! Data(contentsOf: url))
          self.photoCache[reference] = downloadedPhoto
          var image: UIImage
          //print(downloadedPhoto?.images?[0])
          DispatchQueue.main.async {
            completion(downloadedPhoto)
          }
        }
        else {
          DispatchQueue.main.async {
            completion(nil)
          }
        }
      }) .resume()
    }
  }
}

