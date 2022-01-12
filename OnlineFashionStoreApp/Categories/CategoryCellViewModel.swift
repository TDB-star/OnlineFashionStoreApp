//
//  CategoryCellViewModel.swift
//  OnlineFashionStoreApp
//
//  Created by Tatiana Dmitrieva on 12/01/2022.
//

import Foundation

protocol CategoryCellViewModelProtocol {
    var categoryName: String { get }
    var imageData: Data? { get }
    var imageUrl: String { get }
    
    init(category: Category)
}

class CategoryCellViewModel: CategoryCellViewModelProtocol {
    
    var imageUrl: String {
        URLS.stringPath.rawValue+category.image!
    }
    
    var categoryName: String {
        category.name
    }
    
    var imageData: Data? {
        ImageManager.shared.fetchImageData(from: imageUrl)
    }
    
    private let category: Category
    
    required init(category: Category) {
        self.category = category
    }
}
