//
//  AboutUsVC.swift
//  TutorialVideos
//
//  Created by Marvin Andara on 8/27/16.
//  Copyright © 2016 MarvinAndara. All rights reserved.
//

import UIKit
import MapKit

class AboutUsVC: UIViewController, MKMapViewDelegate{

    @IBOutlet weak var map: MKMapView!
    
    let regionRadius: CLLocationDistance = 1000
    let locationManager = CLLocationManager()
    let addresses = ["401 Biscayne Blvd., R106, Miami, FL 33132"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        
        
        for address in addresses {
            
           getPlaceMarkFromAddress(address)
            
        }
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        locationAuthStatus()
        
    }
    
    func locationAuthStatus() {
        
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            
            map.showsUserLocation = true
            
        }
        else {
            
            locationManager.requestWhenInUseAuthorization()
            
        }
        
    }
    
    func centerMapOnLocation(location: CLLocation) {
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2, regionRadius * 2)
        
        map.setRegion(coordinateRegion, animated: true)
        
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        
        if let loc = userLocation.location {
            
            centerMapOnLocation(loc)
            
        }
        
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        
        if annotation.isKindOfClass(LocationAnnotation) {
            
            let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
            annoView.pinTintColor = UIColor.greenColor()
            annoView.animatesDrop = true
            return annoView
            
        }
        else if annotation.isKindOfClass(MKUserLocation) {
            
            return nil
            
        }
        else{
            
            return nil
            
        }
        
    }
    
    func createAnnotationForLocation (location: CLLocation) {
        
        let loc = LocationAnnotation(coordinate: location.coordinate)
        map.addAnnotation(loc)
        
    }
    
    func getPlaceMarkFromAddress (address: String) {
        
        CLGeocoder().geocodeAddressString(address) { (placemarks: [CLPlacemark]?, error: NSError?) in
            
            if let marks = placemarks where marks.count > 0 {
                
                if let loc = marks[0].location {
                    
                    self.createAnnotationForLocation(loc)
                    
                }
                
            }
            
        }
        
    }

    @IBAction func backButtonPressed(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}








