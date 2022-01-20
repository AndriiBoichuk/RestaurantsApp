//
//  Artwork.swift
//  RestaurantsExplorer
//
//  Created by Андрій Бойчук on 20.01.2022.
//

import MapKit

class Artwork: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, rating: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = rating
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
}
