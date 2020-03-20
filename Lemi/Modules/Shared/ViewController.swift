//
//  ViewController.swift
//  Lemi
//
//  Created by John Paul Manoza on 20/03/2020.
//  Copyright © 2020 John Paul Manoza. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    public static var id: String {
        return String(describing: self)
    }
}
