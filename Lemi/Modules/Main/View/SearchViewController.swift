//
//  SearchViewController.swift
//  Lemi
//
//  Created by John Paul Manoza on 20/03/2020.
//  Copyright © 2020 John Paul Manoza. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = ViewModel()
    private let bag = DisposeBag()
    private var searchVC: UISearchController!

    override func viewDidLoad() {
        
        super.viewDidLoad()

        customize(); bind(); observe()
    }
    
    private func customize() {

        searchVC = UISearchController(searchResultsController: nil)
        // NOTE: Avoid crash - https://stackoverflow.com/a/32152135/1621850
        searchVC.isActive = false
        searchVC.searchBar.searchBarStyle = .minimal
        searchVC.hidesNavigationBarDuringPresentation = false
        searchVC.dimsBackgroundDuringPresentation = false
        searchVC.searchBar.placeholder = "Search for a city"
        searchVC.searchBar.delegate = self
        navigationItem.titleView = searchVC.searchBar
    }
    
    private func bind() {
        
        viewModel.loadCities()
        
        _ = viewModel.sections.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }
    
    private func observe() {
        
        _ = tableView.rx.modelSelected(CitySectionItem.Row.self).asObservable()
            .subscribe(onNext: { [weak this = self] (model) in
                switch model {
                    case .cityOption(let item):
                        guard let city = item.itemCity else { return }
                        this?.viewModel.setSelectedCity(city: city)
                        // go back
                        DispatchQueue.main.setTimeout(0.2) {
                            this?.navigationController?.popViewController(animated: true)
                        }
                        break
                }
            })
        
        _ = searchVC.searchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { [weak this = self] (query) in
                if query.count >= 1 {
                    this?.viewModel.searchCities(query: query)
                }
            })
            .disposed(by: bag)
    }
}

extension SearchViewController {
    public var dataSource: RxTableViewSectionedReloadDataSource<CitySectionItem> {
        let dataSource = RxTableViewSectionedReloadDataSource<CitySectionItem>(configureCell: { (source, tableView, indexPath, _) in

            switch source[indexPath] {
            case .cityOption(let data):
                let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.id, for: indexPath)
                (cell as! CityCell).city = data.itemCity
                return cell
            }
        })

        return dataSource
    }
}

extension SearchViewController: UISearchBarDelegate, UISearchControllerDelegate {

    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.showsCancelButton = false
    }

    func didDismissSearchController(_ searchController: UISearchController) {
        searchVC.isActive = false
        navigationController?.popViewController(animated: true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchVC.isActive = false
        navigationController?.popViewController(animated: true)
    }
}
