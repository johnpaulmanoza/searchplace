//
//  HomeViewController.swift
//  Lemi
//
//  Created by John Paul Manoza on 20/03/2020.
//  Copyright © 2020 John Paul Manoza. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var selectionLabel: UILabel!
    
    private let viewModel = ViewModel()
    private let bag = DisposeBag()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        customize(); bind()
    }
    
    private func customize() {
        // hide back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func bind() {
        
        _ = viewModel.observeSelectedCity().asObservable()
            .subscribe(onNext: { [weak this = self] (item) in
                guard let cityName = item else { return }
                this?.selectionLabel.isHidden = false
                this?.selectionLabel.text = "You selected: \(cityName)"
            })
    }
}
