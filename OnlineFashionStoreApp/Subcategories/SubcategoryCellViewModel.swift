//
//  SubcategoryCellViewModel.swift
//  OnlineFashionStoreApp
//
//  Created by Tatiana Dmitrieva on 14/01/2022.
//

import Foundation

protocol SubcategoryCellViewModelProtocol {
    var subcategoryName: String { get }
    
    init(subcategory: Subcategory)
}

class SubcategoryCellViewModel: SubcategoryCellViewModelProtocol {
    var subcategoryName: String {
        subcategory.name
    }
    private let subcategory: Subcategory
    
    required init(subcategory: Subcategory) {
        self.subcategory = subcategory
    }
}
