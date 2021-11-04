//
//  IndustryMapVC.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit
import Alamofire
import GoogleMaps
import GooglePlaces
import SwiftyJSON

class IndustryMapVC: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate {
    
    @IBOutlet weak var googleMapView      : GMSMapView!
    @IBOutlet weak var getLocationBtn     : UIButton!
    
    
    @IBOutlet weak var oneLable: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var twoLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var threeLabel: UILabel!
    @IBOutlet weak var staffLabel: UILabel!
    @IBOutlet weak var fourLabel: UILabel!
    @IBOutlet weak var mapLabel: UILabel!
    @IBOutlet weak var fiveLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    
    var count            : Int!
    var currentLocation  : CLLocation?
    var locationManager  = CLLocationManager()
    var lat              : Double?
    var lng              : Double?
    var marker           = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonLanguageData(button: getLocationBtn, key: "Next")
        setLabelLanguageData(label: welcomeLabel, key: "Welcome")
        setLabelLanguageData(label: mapLabel, key: "location")
        setLabelLanguageData(label: hoursLabel, key: "hours")
        setLabelLanguageData(label: staffLabel, key: "staff")
        setLabelLanguageData(label: serviceLabel, key: "Service")
        
        getFitView(targetview: googleMapView, view: self.view)
        getLocationBtn.isHidden = false
        
        setMessageLanguageData(&setMapPageTitle, key: "location")
        self.navigationItem.title = setMapPageTitle
        
        cornerButton(button: getLocationBtn, cornerValue: 6.0, maskToBounds: true)
        cornerLabel(label: oneLable, cornerValue: Float(oneLable.frame.height / 2) , maskToBounds: true)
        cornerLabel(label: twoLabel, cornerValue: Float(twoLabel.frame.height / 2) , maskToBounds: true)
        cornerLabel(label: threeLabel, cornerValue: Float(threeLabel.frame.height / 2) , maskToBounds: true)
        cornerLabel(label: fourLabel, cornerValue: Float(fourLabel.frame.height / 2) , maskToBounds: true)
        cornerLabel(label: fiveLabel, cornerValue: Float(fiveLabel.frame.height / 2) , maskToBounds: true)
        
        getLocationBtn.backgroundColor = .lightGray
        getLocationBtn.isEnabled = false
        
        GMSPlacesClient.shared()
        locationManager.delegate = self
        
        googleMapView.settings.zoomGestures = true
        googleMapView.animate(toViewingAngle: 45)
        googleMapView.isMyLocationEnabled = true
        googleMapView.settings.compassButton = true
        googleMapView.settings.myLocationButton = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        
        
        let searchBtn = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchLocation))
        
        let setLocation = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(setLocations))
        navigationItem.setRightBarButtonItems([searchBtn, setLocation], animated: true)
    }
    
    @objc func searchLocation(){
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    @objc func setLocations(){
        getLocationBtn.backgroundColor = UIColor(red: 37/255, green: 133/255, blue: 87/255, alpha: 0.5)
        getLocationBtn.isEnabled = true
        print("\(self.googleMapView.camera.target.latitude)" + " , " + "\(self.googleMapView.camera.target.longitude)")
        //---------------------------------- get lat & lng ------------------------------------
        lat = self.googleMapView.camera.target.latitude
        lng = self.googleMapView.camera.target.longitude
        print(lat ?? 0.000)
        print(lng ?? 0.000)
        
        //------------------------------------ set Marker -------------------------------------
        marker.position = CLLocationCoordinate2D(latitude: self.googleMapView.camera.target.latitude, longitude: self.googleMapView.camera.target.longitude)
        marker.icon = GMSMarker.markerImage(with: .blue)
        marker.map  = googleMapView
        
        self.googleMapView.animate(toLocation: CLLocationCoordinate2D(latitude: self.googleMapView.camera.target.latitude, longitude: self.googleMapView.camera.target.longitude))
        self.googleMapView.animate(toZoom: 18.0)
    }
    @IBAction func nextTapped(_ sender: Any) {
        businessLat = lat
        businessLng = lng
        performSegue(withIdentifier: "toHours", sender: self)
    }
    
    // ********************************** Auto Complete **********************************
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 14.0)
        self.googleMapView.camera = camera
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error AutoComplete \(error)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while get location\(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //        let location = locationManager.location?.coordinate
        //        let camera = GMSCameraPosition.camera(withLatitude: (location?.latitude)!, longitude: (location?.longitude)!, zoom: 12.0)
        //        //        let camera = GMSCameraPosition.camera(withLatitude: (self.googleMapView.camera.target.latitude), longitude: (self.googleMapView.camera.target.longitude), zoom: 10.0)
        //        self.googleMapView.camera = GMSCameraPosition.camera(withLatitude: (self.googleMapView.camera.target.latitude), longitude: (self.googleMapView.camera.target.longitude), zoom: 14.0)
        //        self.googleMapView?.animate(to: camera)
        //        self.locationManager.stopUpdatingLocation()
        
        let userLocation = locations.last
        let center = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        
        let camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude, zoom: 15);
        self.googleMapView.camera = camera
        self.googleMapView.isMyLocationEnabled = true
        
        //        let marker = GMSMarker(position: center)
        
        print("Latitude :- \(userLocation!.coordinate.latitude)")
        print("Longitude :-\(userLocation!.coordinate.longitude)")
        //        marker.map = self.googleMapView
        
        //        marker.title = "Current Location"
        locationManager.stopUpdatingLocation()
        
        
    }
    
    func displayAlertMsg(userMsg: String){
        setMessageLanguageData(&msgAlert, key: "Warrning")
        setMessageLanguageData(&msgOk, key: "Ok")
        
        let myAlert = UIAlertController(title: msgAlert ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: msgOk,style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
    }
}
