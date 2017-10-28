//
//  MapViewContoller.swift
//  FindNearestPetrolsV2
//
//  Created by Dushko Cizaloski on 10/27/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//"bakery", "bar", "cafe", "grocery_or_supermarket", "restaurant",

import UIKit
import MapKit
import GoogleMaps
class MapViewController: UIViewController, MKMapViewDelegate {
  
  @IBOutlet weak var mapView: GMSMapView!
  @IBOutlet weak var myLocationCenterPinImage: UIImageView!
  //  @IBOutlet weak var myLocationPinImage: UIImageView!
  
  @IBOutlet weak var addressLabel: UILabel!
  
  @IBOutlet weak var pinImageVerticalConstraints: NSLayoutConstraint!
  //  @IBOutlet weak var pinImageVerticalConstraint: NSLayoutConstraint!
  //  @IBOutlet weak var pinImageVerticalConstraint: NSLayoutConstraint!
  //@IBOutlet weak var pinImageVerticalConstraint: NSLayoutConstraint!
  var searchedTypes = ["gas_station"]
  var image: UIImage?
  var button: UIButton?
  var showInfoView: MarkerInfoView?
  let locationManager = CLLocationManager()
  let dataProvider = GoogleDataProvider()
  let searchRadius: Double = 10000
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    
    mapView.delegate = self
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "Types Segue" {
      let navigationController = segue.destination as! UINavigationController
      let controller = navigationController.topViewController as! TypesTableViewController
      controller.selectedTypes = searchedTypes
      controller.delegate = self
    }
  }
  
  func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
    let geocoder = GMSGeocoder()
    
    geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
      self.addressLabel.unlock()
      if let address = response?.firstResult() {
        let lines = address.lines as! [String]
        self.addressLabel.text = lines.joined(separator: "\n")
        
        let labelHeight = self.addressLabel.intrinsicContentSize.height
        self.mapView.padding = UIEdgeInsets(top: self.topLayoutGuide.length, left: 0, bottom: labelHeight, right: 0)
        
        UIView.animate(withDuration: 0.25, animations: {
          self.pinImageVerticalConstraints.constant = ((labelHeight - self.topLayoutGuide.length) * 0.5)
          self.view.layoutIfNeeded()
        })
      }
    }
  }
  
  func fetchNearbyPlaces(_ coordinate: CLLocationCoordinate2D) {
    mapView.clear()
    dataProvider.fetchPlacesNearCoordinate(coordinate, radius:searchRadius, types: searchedTypes) { places in
      for place: GooglePlace in places {
        let marker = PlaceMarker(place: place)
        marker.map = self.mapView
      }
    }
  }
  
//  @IBAction func refreshPlaces(_ sender: AnyObject) {
//    fetchNearbyPlaces(showMapView.camera.target)
//  }
  
  @IBAction func refreshThePlaces(_ sender: Any) {
     fetchNearbyPlaces(mapView.camera.target)
  }
}

// MARK: - TypesTableViewControllerDelegate
extension MapViewController: TypesTableViewControllerDelegate {
  func typesController(_ controller: TypesTableViewController, didSelectTypes types: [String]) {
    searchedTypes = controller.selectedTypes.sorted()
    dismiss(animated: true, completion: nil)
    fetchNearbyPlaces(mapView.camera.target)
  }
}

// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedWhenInUse {
      locationManager.startUpdatingLocation()
      mapView.isMyLocationEnabled = true
      mapView.settings.myLocationButton = true
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
      mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
      locationManager.stopUpdatingLocation()
      fetchNearbyPlaces(location.coordinate)
    }
  }
}

// MARK: - GMSMapViewDelegate
extension MapViewController: GMSMapViewDelegate {
  func mapView(_ mapView: GMSMapView!, idleAt position: GMSCameraPosition!) {
    reverseGeocodeCoordinate(position.target)
  }
  
  func mapView(_ mapView: GMSMapView!, willMove gesture: Bool) {
    addressLabel.lock()
    
    if (gesture) {
      myLocationCenterPinImage.fadeIn(0.25)
      mapView.selectedMarker = nil
    }
  }
  
  func mapView(_ mapView: GMSMapView!, markerInfoContents marker: GMSMarker!) -> UIView! {
    let placeMarker = marker as! PlaceMarker
    
    if let infoView = UIView.viewFromNibName("MarkerInfoView") as? MarkerInfoView {
      infoView.showNameLabel.text = placeMarker.place.name
      
      if let photo = placeMarker.place.photo {
        
        self.button = UIButton(frame: CGRect(x: infoView.bounds.width - 120, y: infoView.bounds.height - 120, width: 80, height: 60))
        self.image = photo
        self.button?.setImage(image, for: .normal)
        
        infoView.addSubview(button!)
        infoView.isUserInteractionEnabled = true
        
      } else {
        image = UIImage(named: "generic")
      }
      return infoView
    } else {
      return nil
    }
  }
  func mapView(_ mapView: GMSMapView!, didTapInfoWindowOf marker: GMSMarker!) {
    print("Show Info")
  }
  
  
  //  func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
  //
  //    showInfoView?.removeFromSuperview()
  //    //    customInfoView.button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
  //    self.view.addSubview(showInfoView!)
  //
  //    // Remember to return false
  //    // so marker event is still handled by delegate
  //    return false
  //  }
  
  func driveDirectionButton()
  {
    print("Here is acction for drive Directions")
  }
  
  
  
  internal func mapView(_ mapView: GMSMapView!, didTap marker: GMSMarker!) -> Bool {
    myLocationCenterPinImage.fadeOut(0.25)
    return false
  }
  
  func didTapMyLocationButton(for mapView: GMSMapView!) -> Bool {
    myLocationCenterPinImage.fadeIn(0.25)
    mapView.selectedMarker = nil
    return false
  }
}

