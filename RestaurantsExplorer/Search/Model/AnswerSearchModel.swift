//
//  AnswerSearchModel.swift
//  RestaurantsExplorer
//
//  Created by Андрій Бойчук on 17.01.2022.
//

import Foundation

struct AnswerSearchModel: Decodable {
    
    let results: [Restaurant]
    
}

struct Restaurant: Decodable {

    let fsq_id: String
    let categories: [Categories]
    let location: Location
    let name: String
    
}

struct Categories: Decodable {
    
    let id: Int
    let name: String
    let icon: Icon
    
}

struct Icon: Decodable {
    
    let prefix: String
    let suffix: String
    
}

struct Location: Decodable {
    
    let address: String?
    let locality: String?
    let region: String?

}
