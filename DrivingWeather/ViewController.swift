//
//  ViewController.swift
//  DrivingWeather
//
//  Created by Alex St George on 2018-01-26.
//  Copyright © 2018 Pelmorex Media Inc. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ViewController: UIViewController {
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    
    var titleBar: TitleBar!
    
    var searchButton: UIButton!
    var myLocationButton: UIButton!
    var pinButton: UIButton!
    
    var zoomLevel: Float = 15.0
    
    var placePinMode = false
    
    var popupView: UIView!
    
    var selectedPin: GMSMarker?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        placesClient = GMSPlacesClient.shared()
        
        setupUI()
        
    }
    
    func setupUI() {
        //Map
        let camera = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: 6.0)
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = true
        mapView.delegate = self
        view.addSubview(mapView)
        
        //Title Bar
        titleBar = TitleBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80))
        titleBar.backgroundColor = UIColor(red: 222/255.0, green: 240/255.0, blue: 254/255.0, alpha: 0.6)
        view.addSubview(titleBar)
        
        //Buttons
        pinButton = UIButton(frame: CGRect(x: view.frame.width-68, y: view.frame.height-132, width: 60, height: 60))
        pinButton.setImage(#imageLiteral(resourceName: "NewIcon"), for: .normal)
        pinButton.addTarget(self, action: #selector(placeNewPinAction), for: .touchUpInside)
        view.addSubview(pinButton)
        
        searchButton = UIButton(frame: CGRect(x: view.frame.width-68, y: view.frame.height-198, width: 60, height: 60))
        searchButton.setImage(#imageLiteral(resourceName: "Search"), for: .normal)
        searchButton.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        view.addSubview(searchButton)
        
        myLocationButton = UIButton(frame: CGRect(x: view.frame.width-68, y: view.frame.height-68, width: 60, height: 60))
        myLocationButton.setImage(#imageLiteral(resourceName: "MyLocation"), for: .normal)
        myLocationButton.addTarget(self, action: #selector(goToMyLocationAction), for: .touchUpInside)
        view.addSubview(myLocationButton)
    }
    
    //Button Function calls
    @objc func placeNewPinAction(sender: UIButton)
    {
        if placePinMode {
            placePinMode = false
            sender.setImage(#imageLiteral(resourceName: "NewIcon"), for: .normal)
            titleBar.title.text = "Super Awesome and Useful App"
        } else {
            placePinMode = true
            sender.setImage(#imageLiteral(resourceName: "cancel"), for: .normal)
            titleBar.title.text = "Tap to Place New Pin"
        }
    }
    
    @objc func goToMyLocationAction(sender: UIButton)
    {
        guard let lat = self.mapView.myLocation?.coordinate.latitude,
            let lng = self.mapView.myLocation?.coordinate.longitude else { return }
        
        let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lng , zoom: zoomLevel)
        self.mapView.animate(to: camera)
    }
    
    @objc func searchAction(sender: UIButton)
    {
        let searchVC = GMSAutocompleteViewController()
        searchVC.delegate = self
        present(searchVC, animated: true, completion: nil)
    }
    
    @objc func pinOptionSelectAction(sender: UIButton)
    {
        if let pinView = popupView as? PinMakerView {
            switch sender {
            case pinView.visibilityButton:
                pinView.visibilityButton.isSelected = true
                pinView.roadCButton.isSelected = false
                pinView.extremeButton.isSelected = false
                
            case pinView.roadCButton:
                pinView.visibilityButton.isSelected = false
                pinView.roadCButton.isSelected = true
                pinView.extremeButton.isSelected = false
                
            case pinView.extremeButton:
                pinView.visibilityButton.isSelected = false
                pinView.roadCButton.isSelected = false
                pinView.extremeButton.isSelected = true
                
            case pinView.lowSeverityButton:
                pinView.lowSeverityButton.isSelected = true
                pinView.medSeverityButton.isSelected = false
                pinView.highSeverityButton.isSelected = false
                
            case pinView.medSeverityButton:
                pinView.lowSeverityButton.isSelected = false
                pinView.medSeverityButton.isSelected = true
                pinView.highSeverityButton.isSelected = false
                
            case pinView.highSeverityButton:
                pinView.lowSeverityButton.isSelected = false
                pinView.medSeverityButton.isSelected = false
                pinView.highSeverityButton.isSelected = true
                
            default: break
            }
            
            if pinView.visibilityButton.isSelected {
                if pinView.highSeverityButton.isSelected {
                    selectedPin?.icon =  UIImage.resizeImageWith(image: #imageLiteral(resourceName: "VisibilityHighPin"), newSize: CGSize(width: 60, height: 60), isOpaque: false)
                } else if pinView.medSeverityButton.isSelected {
                    selectedPin?.icon =  UIImage.resizeImageWith(image: #imageLiteral(resourceName: "VisibilityMedPin"), newSize: CGSize(width: 60, height: 60), isOpaque: false)
                } else {
                    selectedPin?.icon =  UIImage.resizeImageWith(image: #imageLiteral(resourceName: "VisibilityLowPin"), newSize: CGSize(width: 60, height: 60), isOpaque: false)
                }
            } else if pinView.roadCButton.isSelected {
                if pinView.highSeverityButton.isSelected {
                    selectedPin?.icon =  UIImage.resizeImageWith(image: #imageLiteral(resourceName: "RoadConditionHighPin"), newSize: CGSize(width: 60, height: 60), isOpaque: false)
                } else if pinView.medSeverityButton.isSelected {
                    selectedPin?.icon =  UIImage.resizeImageWith(image: #imageLiteral(resourceName: "RoadConditionMedPin"), newSize: CGSize(width: 60, height: 60), isOpaque: false)
                } else {
                    selectedPin?.icon =  UIImage.resizeImageWith(image: #imageLiteral(resourceName: "RoadConditionLowPin"), newSize: CGSize(width: 60, height: 60), isOpaque: false)
                }
            } else if pinView.extremeButton.isSelected {
                if pinView.highSeverityButton.isSelected {
                    selectedPin?.icon =  UIImage.resizeImageWith(image: #imageLiteral(resourceName: "ExtremeHighPin"), newSize: CGSize(width: 60, height: 60), isOpaque: false)
                } else if pinView.medSeverityButton.isSelected {
                    selectedPin?.icon =  UIImage.resizeImageWith(image: #imageLiteral(resourceName: "ExtremeMedPin"), newSize: CGSize(width: 60, height: 60), isOpaque: false)
                } else {
                    selectedPin?.icon =  UIImage.resizeImageWith(image: #imageLiteral(resourceName: "ExtremeLowPin"), newSize: CGSize(width: 60, height: 60), isOpaque: false)
                }
            } else {
                if pinView.highSeverityButton.isSelected {
                    selectedPin?.icon =  UIImage.resizeImageWith(image: #imageLiteral(resourceName: "HighPin"), newSize: CGSize(width: 60, height: 60), isOpaque: false)
                } else if pinView.medSeverityButton.isSelected {
                    selectedPin?.icon =  UIImage.resizeImageWith(image: #imageLiteral(resourceName: "MedPin"), newSize: CGSize(width: 60, height: 60), isOpaque: false)
                } else {
                    selectedPin?.icon =  UIImage.resizeImageWith(image: #imageLiteral(resourceName: "LowPin"), newSize: CGSize(width: 60, height: 60), isOpaque: false)
                }
            }
            
        }
    }
    
    @objc func pinCancelAction(sender: UIButton)
    {
        selectedPin?.map = nil
        selectedPin = nil
        self.popupView.removeFromSuperview()
    }
    
    @objc func pinSaveAction(sender: UIButton)
    {
        if let pinView = popupView as? PinMakerView {
            var validSaveOperation = false
            if pinView.visibilityButton.isSelected {
                if pinView.highSeverityButton.isSelected {
                    validSaveOperation = true
                } else if pinView.medSeverityButton.isSelected {
                    validSaveOperation = true
                } else if pinView.lowSeverityButton.isSelected  {
                    validSaveOperation = true
                }
            } else if pinView.roadCButton.isSelected {
                if pinView.highSeverityButton.isSelected {
                    validSaveOperation = true
                } else if pinView.medSeverityButton.isSelected {
                    validSaveOperation = true
                } else if pinView.lowSeverityButton.isSelected {
                    validSaveOperation = true
                }
            } else if pinView.extremeButton.isSelected {
                if pinView.highSeverityButton.isSelected {
                    validSaveOperation = true
                } else if pinView.medSeverityButton.isSelected {
                    validSaveOperation = true
                } else if pinView.lowSeverityButton.isSelected {
                    validSaveOperation = true
                }
            }
            
            if validSaveOperation {
                self.popupView.removeFromSuperview()
            } else {
                let alertController = UIAlertController(title: "Invalid Alert", message: "Please make sure you select the alert type and severity of the event before saving.", preferredStyle: .alert)
                //We add buttons to the alert controller by creating UIAlertActions:
                let actionOk = UIAlertAction(title: "OK",
                                             style: .default,
                                             handler: nil) //You can use a block here to handle a press on this button
                
                alertController.addAction(actionOk)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayCreatePin() {
        let pinView = PinMakerView(frame: CGRect(x: 30, y: view.frame.size.height/2 - 220 + 30, width: view.frame.size.width-60, height: 440))
        pinView.backgroundColor = UIColor(red: 72/255.0, green: 137/255.0, blue: 199/255.0, alpha: 0.8)
        
        pinView.causeTextField.delegate = self
        pinView.otherTextView.delegate = self
        
        pinView.visibilityButton.addTarget(self, action: #selector(pinOptionSelectAction), for: .touchUpInside)
        pinView.roadCButton.addTarget(self, action: #selector(pinOptionSelectAction), for: .touchUpInside)
        pinView.extremeButton.addTarget(self, action: #selector(pinOptionSelectAction), for: .touchUpInside)
        pinView.lowSeverityButton.addTarget(self, action: #selector(pinOptionSelectAction), for: .touchUpInside)
        pinView.medSeverityButton.addTarget(self, action: #selector(pinOptionSelectAction), for: .touchUpInside)
        pinView.highSeverityButton.addTarget(self, action: #selector(pinOptionSelectAction), for: .touchUpInside)
        pinView.saveButton.addTarget(self, action: #selector(pinSaveAction), for: .touchUpInside)
        pinView.cancelButton.addTarget(self, action: #selector(pinCancelAction), for: .touchUpInside)
        
        
        popupView = pinView
        view.addSubview(popupView)
    }
    


}

extension ViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        if placePinMode {
            placePinMode = !placePinMode
            placePinMode = false
            pinButton.setImage(#imageLiteral(resourceName: "NewIcon"), for: .normal)
            titleBar.title.text = "Super Awesome and Useful App"
            
            let marker = GMSMarker(position:coordinate)
            marker.map = mapView
            marker.icon =  UIImage.resizeImageWith(image: #imageLiteral(resourceName: "LowPin"), newSize: CGSize(width: 60, height: 60), isOpaque: false)
            let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude+0.003, longitude: coordinate.longitude, zoom: zoomLevel)
            
            if mapView.isHidden {
                mapView.isHidden = false
                mapView.camera = camera
            } else {
                mapView.animate(to: camera)
            }
            selectedPin = marker
            
            displayCreatePin()
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
        
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}

extension ViewController:  GMSAutocompleteViewControllerDelegate {
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let marker = GMSMarker(position:place.coordinate)
        marker.title = place.name
        marker.snippet = place.formattedAddress
        marker.map = mapView
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5, animations: {
            self.popupView.transform = self.popupView.transform.translatedBy(x: 0, y: -150)
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textFieldDidEndEditing(textField)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        UIView.animate(withDuration: 0.5, animations: {
            self.popupView.transform = self.popupView.transform.translatedBy(x: 0, y: 75)
        })
    }
}

extension UIImage {
    
    static func resizeImageWith(image: UIImage, newSize: CGSize, isOpaque: Bool) -> UIImage {
        
        let horizontalRatio = newSize.width / image.size.width
        let verticalRatio = newSize.height / image.size.height
        
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: image.size.width * ratio, height: image.size.height * ratio)
        var newImage: UIImage
        
        if #available(iOS 10.0, *) {
            let renderFormat = UIGraphicsImageRendererFormat.default()
            renderFormat.opaque = false
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: newSize.width, height: newSize.height), format: renderFormat)
            newImage = renderer.image {
                (context) in
                image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(CGSize(width: newSize.width, height: newSize.height), isOpaque, 0)
            image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            newImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
        }
        
        return newImage
    }
}
