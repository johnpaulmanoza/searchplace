//
//  Dispatch.swift
//  Lemi
//
//  Created by John Paul Manoza on 20/03/2020.
//  Copyright © 2020 John Paul Manoza. All rights reserved.
//

import Foundation

public extension DispatchQueue {
    func setTimeout(_ seconds: Double = 0.5, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
    }
}
