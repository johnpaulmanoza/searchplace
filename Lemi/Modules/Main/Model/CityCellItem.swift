//
//  CityCellItem.swift
//  Lemi
//
//  Created by John Paul Manoza on 20/03/2020.
//  Copyright © 2020 John Paul Manoza. All rights reserved.
//

import Foundation
import RxDataSources

enum CitySectionItem: SectionModelType {

    typealias Item = Row

    case listSection(header: String, items: [Row])

    enum Row {
        // declare per row type/layout
        case cityOption(item: CityCellItem)
    }

    // followings are not directly related to this topic, but represents how to conform to SectionModelType
    var items: [Row] {
        switch self {
        case .listSection(_, let items):
            return items
        }
    }

    public init(original: CitySectionItem, items: [Row]) {
        switch original {
        case .listSection(let header, _):
            self = .listSection(header: header, items: items)
        }
    }
}

class CityCellItem {

    var itemCity: City?

    init(city: City) {
        itemCity = city
    }
}
