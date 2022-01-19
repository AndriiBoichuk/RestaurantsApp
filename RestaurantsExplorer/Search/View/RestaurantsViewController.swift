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
    private let categorySegmentedControl = UISegmentedControl(items: ["All", "American", "Asian", "English", "French"])
    
    private var lastSearchedCity = L10n.Default.city
    
    private let viewModel: RestaurantsViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        searchController.searchBar.delegate = self
        viewModel.delegate = self

        initNavBar()
        initSegmentedControl()
        initTableView()
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
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(categorySegmentedControl.snp_bottomMargin).offset(10)
        }
        let cell = UINib(nibName: L10n.TableView.cell, bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: L10n.Cell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func initNavBar() {
        title = L10n.Title.Label.search
        navigationItem.searchController = searchController
    }

    private func initSegmentedControl() {
        view.addSubview(categorySegmentedControl)
        categorySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        let guide = self.view.safeAreaLayoutGuide
        categorySegmentedControl.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -10).isActive = true
        categorySegmentedControl.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 10).isActive = true
        categorySegmentedControl.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        categorySegmentedControl.selectedSegmentIndex = 0
    
        categorySegmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
    }

    @objc func segmentedValueChanged(_ sender: UISegmentedControl!) {
        let category = getCategory(at: sender.selectedSegmentIndex)
        viewModel.loadRestaurants(city: lastSearchedCity, category: category)
    }

    private func getCategory(at index: Int) -> String {
        var currentCategory: Category
        switch categorySegmentedControl.selectedSegmentIndex {
        case 0: currentCategory = .all
        case 1: currentCategory = .american
        case 2: currentCategory = .asian
        case 3: currentCategory = .english
        default: currentCategory = .french
        }
        return currentCategory.rawValue
    }

}

// MARK: - TableView Delegate, DataSource Methods

extension RestaurantsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: L10n.Cell.identifier, for: indexPath) as! TableViewCell
        let restaurant = viewModel.getRestaurant(at: indexPath)
        let location = restaurant.location
        cell.nameLabel.text = restaurant.name
        let address = location.address ?? " "
        let locality = location.locality ?? " "
        let region = location.region ?? " "
        cell.locationLabel.text = address + " " + locality + " " + region
        cell.categoryLabel.text = restaurant.categories[0].name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let id = viewModel.getId(at: indexPath)
        let answerManager = viewModel.getAnswerManager()
        let detailViewModel = DetailViewModel(answerManager)
        let vc = DetailViewController(id: id, viewModel: detailViewModel)
        navigationController?.pushViewController(vc, animated: true)
    }

}

// MARK: - UISearchBar Delegate Methods

extension RestaurantsViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            lastSearchedCity = text
            let index = categorySegmentedControl.selectedSegmentIndex
            let category = getCategory(at: index)
            viewModel.loadRestaurants(city: text, category: category)
            searchBar.text = ""
        }
    }

}

// MARK: - View Model Delegate

extension RestaurantsViewController: ViewModelDelegate {

    func updateView() {
        tableView.reloadData()
    }

}
