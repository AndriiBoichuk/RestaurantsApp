//
//  RestaurantsViewModel.swift
//  RestaurantsExplorer
//
//  Created by Андрій Бойчук on 17.01.2022.
//

import Foundation

class RestaurantsViewModel {
    
    private let answerManager: AnswerManager
    var delegate: ViewModelDelegate?
    
    private var restaurants = [Restaurant]()
    
    init(_ answerManager: AnswerManager) {
        self.answerManager = answerManager
    }
    
    func loadRestaurants(city: String = "Kyiv", category: String = "13065") {
        answerManager.getRestaurants(in: city, category: category) { answerSearchModel in
            guard let result = answerSearchModel else { return }
            self.restaurants = result.results
            self.delegate?.updateTableView()
        }
    }
    
    func getRestaurant(at indexPath: IndexPath) -> Restaurant {
        return restaurants[indexPath.row]
    }
    
    func getCount() -> Int {
        return restaurants.count
    }
    
}
