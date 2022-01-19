//
//  DetailViewModel.swift
//  RestaurantsExplorer
//
//  Created by Андрій Бойчук on 18.01.2022.
//

import Foundation

class DetailViewModel {
    
    private let answerManager: AnswerManager
    private var restaurantDetail: RestaurantDetailModel?
    var delegate: ViewModelDelegate?
    
    init(_ answerManager: AnswerManager) {
        self.answerManager = answerManager
    }
    
    func loadRestaurantDetail(at id: String) {
        answerManager.getDetailInfo(at: id) { restaurantInfo in
            self.restaurantDetail = restaurantInfo
            self.delegate?.updateView()
        }
    }
    
    func getName() -> String {
        if let name = restaurantDetail?.name {
            return name
        } else {
            return "Unnowned"
        }
    }
    
    func getDescription() -> String {
        if let description = restaurantDetail?.description {
            return description
        } else {
            return ""
        }
    }
    
    func getTelephone() -> String {
        if let telephone = restaurantDetail?.tel {
            return telephone
        } else {
            return ""
        }
    }
    
    func getRating() -> String {
        if let rating = restaurantDetail?.rating {
            return String(rating)
        } else {
            return ""
        }
    }
    
    func getLocation() -> String {
        let address = restaurantDetail?.location.address ?? ""
        let locality = restaurantDetail?.location.locality ?? ""
        let region = restaurantDetail?.location.region ?? ""
        let location = address + " " + locality + " " + region
        return location
    }
    
}
