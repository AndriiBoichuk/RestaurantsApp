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
    private let headers: HTTPHeaders = [
        "Accept": "application/json",
        "Authorization": "fsq3pGRvF9MTSiYPkwXa1V4lbOiElcjsqmsGnVTygxC4uhg="
    ]

    func getRestaurants(in city: String, category: String, completion: @escaping (AnswerSearchModel?) -> Void) {
        let urlString = "https://api.foursquare.com/v3/places/search?categories="
        + category + "&near="
        + city + "&limit=20"
        var model: AnswerSearchModel?

        dispatchGroup.enter()
        AF.request(urlString, headers: headers)
            .responseDecodable(of: AnswerSearchModel.self, queue: queue) { response in
            guard let receivedResults = response.value else { return }
            model = receivedResults
            self.dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
            completion(model)
        }

    }
    
    func getDetailInfo(at id: String, completion: @escaping (RestaurantDetailModel?) -> Void) {
        let urlString = "https://api.foursquare.com/v3/places/" + id + "?fields=name%2Clocation%2Cdescription%2Ctel%2Crating%2Cgeocodes"
        var restaurantDetail: RestaurantDetailModel?
        dispatchGroup.enter()
        AF.request(urlString, headers: headers).responseDecodable(of: RestaurantDetailModel.self, queue: queue) { response in
            guard let restaurantInfo = response.value else { return }
            restaurantDetail = restaurantInfo
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            completion(restaurantDetail)
        }
    }

}
