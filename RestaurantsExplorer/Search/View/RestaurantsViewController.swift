//
//  ViewController.swift
//  RestaurantsExplorer
//
//  Created by Андрій Бойчук on 17.01.2022.
//

import UIKit

class RestaurantsViewController: UIViewController {

    private let viewModel: RestaurantsViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    init(viewModel: RestaurantsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

