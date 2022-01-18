//
//  ViewController.swift
//  RestaurantsExplorer
//
//  Created by Андрій Бойчук on 17.01.2022.
//

import UIKit
import SnapKit

class RestaurantsViewController: UIViewController {

    private let tableView = UITableView()
    private let searchController = UISearchController()
    
    private let viewModel: RestaurantsViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        searchController.searchBar.delegate = self
        viewModel.delegate = self
        
        initTableView()
        initNavBar()
        viewModel.loadRestaurants()
    }
    
    init(viewModel: RestaurantsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let cell = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "CustomCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func initNavBar() {
        title = "Restaurants"
        navigationItem.searchController = searchController
    }

}

// MARK: - TableView Delegate, DataSource Methods

extension RestaurantsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! TableViewCell
        let restaurant = viewModel.getRestaurant(at: indexPath)
        let location = restaurant.location
        cell.nameLabel.text = restaurant.name
        let address = location.address
        let locality = location.locality ?? " "
        let region = location.region ?? " "
        cell.locationLabel.text = address + locality + region
        cell.categoryLabel.text = restaurant.categories[0].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - UISearchBar Delegate Methods

extension RestaurantsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
}

// MARK: - View Model Delegate

extension RestaurantsViewController: ViewModelDelegate {
    
    func updateTableView() {
        tableView.reloadData()
    }
    
}

