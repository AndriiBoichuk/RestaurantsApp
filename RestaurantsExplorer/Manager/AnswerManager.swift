//
//  AnswerManager.swift
//  RestaurantsExplorer
//
//  Created by Андрій Бойчук on 17.01.2022.
//

import Foundation
import Alamofire

class AnswerManager {
    
    private let queue = DispatchQueue.global(qos: .userInitiated)
    private let dispatchGroup = DispatchGroup()
    
    func getRestaurants(in city: String, category: String, completion: @escaping (AnswerSearchModel?) -> ()) {
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "fsq3pGRvF9MTSiYPkwXa1V4lbOiElcjsqmsGnVTygxC4uhg="
        ]
        let urlString = "https://api.foursquare.com/v3/places/search?categories=" + category + "&near=" + city + "&limit=20"
        var model: AnswerSearchModel?
        
        dispatchGroup.enter()
        AF.request(urlString, headers: headers).responseDecodable(of: AnswerSearchModel.self, queue: queue) { response in
            guard let receivedResults = response.value else { return }
            model = receivedResults
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(model)
        }
        
    }
    
}
