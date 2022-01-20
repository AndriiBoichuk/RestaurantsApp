//
//  RestaurantDetailModel.swift
//  RestaurantsExplorer
//
//  Created by Андрій Бойчук on 18.01.2022.
//

import Foundation

struct RestaurantDetailModel: Decodable {
 
    let description: String?
    let geocodes: Locality
    let location: Location
    let name: String
    let rating: Double?
    let tel: String?
    
}

struct Locality: Decodable {
    
    let main: Coordinate
    
}

struct Coordinate: Decodable {
    
    let latitude: Double
    let longitude: Double
    
}
