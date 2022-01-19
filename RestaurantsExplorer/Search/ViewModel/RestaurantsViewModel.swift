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
    
    func loadRestaurants(city: String = L10n.Default.city, category: String = L10n.Default.category) {
        answerManager.getRestaurants(in: city, category: category) { answerSearchModel in
            guard let result = answerSearchModel else { return }
            self.restaurants = result.results
            self.delegate?.updateView()
        }
    }
    
    func getAnswerManager() -> AnswerManager {
        return answerManager
    }
    
    func getRestaurant(at indexPath: IndexPath) -> Restaurant {
        return restaurants[indexPath.row]
    }
    
    func getCount() -> Int {
        return restaurants.count
    }
    
    func  getId(at indexPath: IndexPath) -> String {
        return restaurants[indexPath.row].fsq_id
    }
    
}
