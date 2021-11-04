
//
//  SettingMapVC.swift
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

class SettingMapVC: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate {

    @IBOutlet weak var googleMapView      : GMSMapView!
    @IBOutlet weak var getLocationBtn     : UIButton!
    
    
    var count            : Int!
    var currentLocation  : CLLocation?
    var locationManager  = CLLocationManager()
    var lat              : Double?
    var lng              : Double?
    var marker           = GMSMarker()
    var providerMarker   = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setButtonLanguageData(button: getLocationBtn, key: "Update location")
        
        setMessageLanguageData(&providerLocationPageTitle, key: "location")
        self.navigationItem.title = providerLocationPageTitle
        
        cornerButton(button: getLocationBtn, cornerValue: 6.0, maskToBounds: true)
        
//        print(providerLat)
//        print(providerLng)
        
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
        
        setProviderMarker()
        
//        let button = UIButton.init(type: .custom)
//        let widthConstraint = button.widthAnchor.constraint(equalToConstant: 50)
//        let heightConstraint = button.heightAnchor.constraint(equalToConstant: 50)
//        heightConstraint.isActive = true
//        widthConstraint.isActive = true
//        button.frame = CGRect.init(x: 0, y: 0, width: 50, height: 50)
//        cornerButton(button: button, cornerValue: 4.0, maskToBounds: true)
//        button.setImage(UIImage.init(named: "umaassIcon.png"), for: UIControl.State.normal)
//        let logoImg = UIBarButtonItem.init(customView: button)
        
        let searchBtn = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchLocation))
        navigationItem.rightBarButtonItem = searchBtn
    }
    
    @objc func searchLocation(){
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        self.locationManager.startUpdatingLocation()
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    func setProviderMarker() {
        providerMarker.position = CLLocationCoordinate2D(latitude: Double(providerLat ?? "0.00") ?? 0.00, longitude: Double(providerLng ?? "0.00") ?? 0.00)
        providerMarker.icon = GMSMarker.markerImage(with: .red)
        providerMarker.map  = googleMapView
        self.googleMapView.delegate = self
    }
    
    @IBAction func getLocationTapped(_ sender: Any) {
        providerMarker.map = nil
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
        self.googleMapView.animate(toZoom: 12.0)
        self.updateLocation()
    }
    
// ********************************** Auto Complete **********************************
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 16.0)
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
    
// ************************************ update location *************************************
    func updateLocation(){
        loading()
        let updateMapUrl = baseUrl + "industries/" + "\(industryID ?? 1)"
        print(updateMapUrl)
        
        let model = updateLocationModel(lat: self.lat, lng: self.lng)
        print(model)
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(model)
            jsonEncoder.outputFormatting = .prettyPrinted
            
            let url = URL(string: updateMapUrl)
            var request = URLRequest(url: url!)
            request.httpMethod = HTTPMethod.put.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            request.allHTTPHeaderFields = [
                "Authorization": "Bearer \(accesssToken)",
                "X-Requested-With": "application/json",
                "Content-type" : "application/json",
                "Accept" : "application/json"
            ]
            
            print(jsonData)
            Alamofire.request(request).responseJSON {
                (response) in
                self.dismissLoding()
                print(response)
//                print(response.response?.statusCode)
                let status = response.response?.statusCode
//                print(status)
                if (response.result.value) != nil {
                    let swiftyJsonVar = JSON(response.result.value)
                    print("swiftyJsonVar ---------- ",swiftyJsonVar)
                    if let resData = swiftyJsonVar["data"].dictionaryObject {
                        print(resData)
                     
                        setMessageLanguageData(&updateLocationn, key: "update Location")
                        self.displaySuccessMsg(userMsg: updateLocationn)
                    }else{
                        setMessageLanguageData(&someThingWentWrong, key: "somthing went wrong")
                        self.displayAlertMsg(userMsg: someThingWentWrong)
                    }
                }
            }
        }catch {
            
        }
    }
    
    
    func displaySuccessMsg(userMsg: String){
        setMessageLanguageData(&successfullyDone, key: "Successfully Done")
        setMessageLanguageData(&msgOk, key: "Ok")
        
        let myAlert = UIAlertController(title: successfullyDone ,message: userMsg, preferredStyle: UIAlertController.Style.alert)
        let okAction = (UIAlertAction(title: msgOk, style: .default, handler: { action in
            print("savesd location")
            self.navigationController?.popViewController(animated: true)
        }))
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil);
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

var updateLocationn = String()
