//
//  DropDownMenuModels.swift
//  DropDownMenuTest
//
//  Created by Ahmed Sallam on 01/05/2023.
//

import Foundation

struct DropDownMenuOption<T> {
    var displayableTitle: String
    var value: T
    
    init(displayableTitle: String, value: T) {
        self.displayableTitle = displayableTitle
        self.value = value
    }
}

struct DropDownMenuSection<T> {
    var sectionTitle: String
    var subList: [DropDownMenuOption<T>]
}
