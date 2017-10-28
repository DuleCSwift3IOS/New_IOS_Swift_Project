////
////  ViewController.swift
////  FindNearestPetrolsV2
////
////  Created by Dushko Cizaloski on 9/25/17.
////  Copyright © 2017 Big Nerd Ranch. All rights reserved.
////
//
//import UIKit
//import MapKit
//import CoreLocation
//import Alamofire
//import AlamofireObjectMapper
//import Kingfisher
//class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
//  @IBOutlet weak var showMapView: MKMapView!
//  var statusCode: Int!
//  var locationManager = CLLocationManager()
//  var currentDistance: Int!
//  var allPlacesDictionary = NSDictionary()
//  var firstlaunch : Bool = false
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    //Make this controller the delegate for the map view.
//    self.mapView.delegate = self
//    // Ensure that we can view our own location in the map view.
//    self.mapView.showsUserLocation = true
//    //Instantiate a location object.
//    locationManager = CLLocationManager()
//    //Make this controller the delegate for the location manager.
//    locationManager.delegate = self
//    //Set some paramater for the location object.
//    locationManager.distanceFilter = kCLDistanceFilterNone
//    locationManager.desiredAccuracy = kCLLocationAccuracyBest
//    //Set the first launch instance variable to allow the map to zoom on the user location when first launched.
//    firstlaunch = true
//    // Do any additional setup after loading the view, typically from a nib.
//
////    createURLWithComponents(date: NSDate())
//  }
//  @IBOutlet weak var mapView: MKMapView!
////  @IBOutlet weak var imageForPetrols: UIImageView!
//  var arrayResults: [Results] = []
//
//  override func didReceiveMemoryWarning() {
//    super.didReceiveMemoryWarning()
//    // Dispose of any resources that can be recreated.
//  }
//
////  func queryGooglePlaces(googleType: NSString )
////  {
////    // Build the url string we are going to sent to Google. NOTE: The kGOOGLE_API_KEY is a constant which should contain your own API key that you can obtain from Google. See this link for more info: location:currentCenter.latitude,currentCenter.longitude&radius=currentDistance
////
////    let GoogleURL = URL(string: "https://maps.googleapis.com/maps/api/place/search/json?location=\("41.606315612792969"),\("21.741931915283232")&radius=\("100000")&types=\(googleType)&sensor=true&key=\(API_KEY)")
////    weak var weakSelf = self
////
////
////  Alamofire.request(GoogleURL!).responseJSON { (response) in
////    switch response.result
////    {
////    case .success:
////    if let objJson = response.result.value as! [String: AnyObject]?
////    {
////      let place = objJson["results"]
////      // print(place!)
////      if let arrayResults = place
////      {
////      for objectResults in arrayResults as! NSArray
////      {
////      self.arrayResults.append(Results(jsonDic: objectResults as! NSDictionary))
////      //print(objectResults)
////      var getElements = self.arrayResults
////      var i = 0
////      for j in 0..<getElements.count
////      {
////        var showName = getElements[i].name as! String
////        var showAddress = getElements[i].vicinity as! String
////        var showLocationLat = getElements[i].latitude
////        var showLocationLng = getElements[i].langitude
//////     print(getElements[j].vicinity!)
//////     print(getElements[j].rating)
//////     print(getElements[i].geometry)
//////     print(getElements[i].location) as? NSDictionary
//////     print(getElements[i].langitude)
//////     print(getElements[i].latitude)
////
////
////       //i = j + 1
////        print(getElements[j].image)
////
////      }
////        let placeObject: MapPointAnnotation =  self.showMapView.isKind(of: MapPointAnnotation.init(name: "", address: "", cooridinate: getElements[i].latitude?.ulp , title: "", subtitle: ""))//.init(name: getName as! String, address: getAddress as! String, cooridinate: CLLocationCoordinate2D(latitude: getLocationLat as! CLLocationDegrees, longitude: getLocationLon as! CLLocationDegrees), title: getName as! String, subtitle: getAddress as! String)
////        self.mapView.addAnnotation(placeObject as! MKAnnotation)      }
////      }
////    }
////      case .failure(let error):
////        print("Error: \(error)")
////   }
////  }
////}
//
//  func queryGooglePlaces(googleType: NSString)
//  {
//
//  }
//
//  func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView
//  {
//    if !(annotation is MKUserLocation) {
//      print("You dont have an information")
//    }
//
//    let identifier = "CustomIdentifier"
//    var annotationVIew = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//    if annotationVIew == nil
//    {
//      MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
////      let urlKingFisher = URL(fileURLWithPath: self.arrayResults[0].image!)
////      print(self.imageForPetrols.kf.setImage(with: urlKingFisher))
////      annotationVIew?.image = UIImage(contentsOfFile: urlKingFisher.absoluteString)
//    } else {
//      annotationVIew?.annotation = annotation
//    }
//    return annotationVIew!
//
//  }
//  func annotationPosition(_ data: NSArray)
//  {
//    //Remove any existing custom annotations but not the user location blue dot.
//    for annotation: MKAnnotation in mapView.annotations
//    {
//      if annotation.isKind(of: MapPointAnnotation.superclass()!)
//      {
//        mapView.removeAnnotation(annotation)
//      }
//    }
//     //Loop through the array of places returned from the Google API.
//  }
//  @IBAction func toolBarButtonPress(_ sender: Any) {
//    let button: UIBarButtonItem = sender as! UIBarButtonItem
//    var buttonTitle: String = (button.title?.lowercased())!
//    var insertIntoArry = [buttonTitle]
//    if buttonTitle == "gas_station"
//    {
//    self.queryGooglePlaces(googleType: buttonTitle as NSString)
//
//    } else {
//    if buttonTitle == "bar"
//    {
//    self.queryGooglePlaces(googleType: buttonTitle as NSString)
//    } else {
//    if buttonTitle == "atm"
//    {
//    self.queryGooglePlaces(googleType: buttonTitle as NSString)
//    }
//    }
//  buttonTitle.removeAll()
//   }
//  }
//
//}

