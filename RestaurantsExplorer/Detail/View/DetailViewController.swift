//
//  DetailViewController.swift
//  RestaurantsExplorer
//
//  Created by Андрій Бойчук on 18.01.2022.
//

import UIKit
import SnapKit
import MapKit

class DetailViewController: UIViewController {

    private let nameLabel = UILabel()
    private let locationLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let telephoneLabel = UILabel()
    private let ratingLabel = UILabel()
    private let mapView = MKMapView()
    
    private let viewModel: DetailViewModel
    
    private let id: String
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        
        initView()
        viewModel.loadRestaurantDetail(at: id)
    }
    
    init(id: String, viewModel: DetailViewModel) {
        self.id = id
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        view.backgroundColor = .white
        
        title = L10n.Title.Label.detail
        
        initNameLabel()
        initLocationLabel()
        initRatingLabel()
        initDescriptionLabel()
        initTelephoneLabel()
        initMapView()
    }
    
    private func initNameLabel() {
        view.addSubview(nameLabel)
        nameLabel.font = UIFont(name: L10n.Font.Detail.cochin, size: 36)
        nameLabel.numberOfLines = 2
        nameLabel.textAlignment = .center
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(15)
            make.trailing.leading.equalToSuperview().inset(15)
        }
    }
    
    private func initLocationLabel() {
        view.addSubview(locationLabel)
        locationLabel.font = UIFont(name: L10n.Font.Detail.charter, size: 18)
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.trailing.leading.equalToSuperview().inset(15)
        }
    }
    
    private func initRatingLabel() {
        view.addSubview(ratingLabel)
        ratingLabel.font = UIFont(name: L10n.Font.Detail.Helvetica.bold, size: 14)
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(15)
            make.trailing.leading.equalToSuperview().inset(15)
        }
    }
    
    private func initDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.font = UIFont(name: L10n.Font.Detail.Helvetica.ultralight, size: 18)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel.snp_bottomMargin).offset(30)
            make.trailing.leading.equalToSuperview().inset(15)
        }
    }
    
    private func initTelephoneLabel() {
        view.addSubview(telephoneLabel)
        telephoneLabel.font = UIFont(name: L10n.Font.Detail.Helvetica.ultralight, size: 28)
        telephoneLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
        }
    }
    
    private func initMapView() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp_bottomMargin).offset(40)
            make.bottom.equalTo(telephoneLabel.snp_topMargin).offset(-20)
            make.trailing.leading.equalToSuperview().inset(20)
        }
        mapView.layer.cornerRadius = 10
    }

}

// MARK: - View Model Delegate

extension DetailViewController: ViewModelDelegate {
    
    func updateView() {
        nameLabel.text = viewModel.getName()
        locationLabel.text = viewModel.getLocation()
        ratingLabel.text = "Rating: " + viewModel.getRating()
        descriptionLabel.text = viewModel.getDescription()
        let telephone = viewModel.getTelephone()
        if !telephone.isEmpty {
            telephoneLabel.text = "Tel: " + telephone
        }
        if let coordinates = viewModel.getCoordinates() {
            let latitude = coordinates.latitude
            let longitude = coordinates.longitude
            let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
            mapView.centerToLocation(initialLocation)
            let title = viewModel.getName()
            let rating = "Rate: " + viewModel.getRating()
            let artwork = Artwork(title: title, rating: rating, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            mapView.addAnnotation(artwork)
        }
        
    }
    
}

private extension MKMapView {
    
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
    
}
