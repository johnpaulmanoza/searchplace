//
//  HomeViewModel.swift
//  Lemi
//
//  Created by John Paul Manoza on 20/03/2020.
//  Copyright © 2020 John Paul Manoza. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

class ViewModel {
    
    public var sections: Variable<[CitySectionItem]> = Variable([])
    
    private let api = APIManager()
    private let bag = DisposeBag()
    
    init() {
        
    }
    
    public func loadCities() {
        _ = api.loadCities().asObservable()
            .subscribe(onNext: { [weak this = self] (items) in
                guard let cities = items as? [City] else { return }
                this?.showItems(cities: cities)
            })
            .disposed(by: bag)
    }
    
    public func searchCities(query: String) {
        _ = api.loadCities(query: query).asObservable()
            .subscribe(onNext: { [weak this = self] (items) in
                guard let cities = items as? [City] else { return }
                this?.showItems(cities: cities)
            })
            .disposed(by: bag)
    }
    
    public func setSelectedCity(city: City) {
        UserDefaults.standard.set(city.cityName, forKey: "selected_city")
        UserDefaults.standard.synchronize()
    }
    
    public func observeSelectedCity() -> Observable<(String?)> {
        return UserDefaults.standard.rx.observe(String.self, "selected_city").asObservable()
    }
    
    private func showItems(cities: [City]) {
        
        let items = cities
            .map { CityCellItem(city: $0) }
            .map { CitySectionItem.Row.cityOption(item: $0) }

        sections.value = [
            CitySectionItem.listSection(header: "Cities", items: items)
        ]
    }
}
