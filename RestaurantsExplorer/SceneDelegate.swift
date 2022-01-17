//
//  SceneDelegate.swift
//  RestaurantsExplorer
//
//  Created by Андрій Бойчук on 17.01.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
 
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let answerManager = AnswerManager()
        let viewModel = RestaurantsViewModel(answerManager)
        let restaurantVC = RestaurantsViewController(viewModel: viewModel)
        let navigationVC = UINavigationController(rootViewController: restaurantVC)
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
    }

}

