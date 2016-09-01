//
//  LocationAnnotation.swift
//  TutorialVideos
//
//  Created by Marvin Andara on 8/27/16.
//  Copyright © 2016 MarvinAndara. All rights reserved.
//

import Foundation
import MapKit

class LocationAnnotation: NSObject, MKAnnotation {
    
    var coordinate = CLLocationCoordinate2D()
    
    init(coordinate: CLLocationCoordinate2D){
        
        self.coordinate = coordinate
        
    }
    
}