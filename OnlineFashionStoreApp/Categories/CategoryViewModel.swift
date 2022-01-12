//
//  CategoryViewModel.swift
//  OnlineFashionStoreApp
//
//  Created by Tatiana Dmitrieva on 12/01/2022.
//

import Foundation

protocol CategoryViewModelProtocol {
    
    var categories: [Category] { get }
    func fetchData(completion: @escaping() -> Void)
    func getNumberOfRows() -> Int
    func getCellViewModel(at indexPath: IndexPath) -> CategoryCellViewModelProtocol
//    func getSubcategoryViewModel(at indexPath: IndexPath) -> SubcategoriesViewModelProtocol
}

class CategoryListViewModel: CategoryViewModelProtocol {

    var categories: [Category] = []
    
    func fetchData(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchData { categories in
            self.categories = categories
            completion()
        }
    }
    
    func getNumberOfRows() -> Int {
        categories.count
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> CategoryCellViewModelProtocol {
        let category = categories[indexPath.row]
        return CategoryCellViewModel(category: category)
    }
    
//    func getSubcategoryViewModel(at indexPath: IndexPath) -> SubcategoriesViewModelProtocol {
//        let subcategory = categories[indexPath.row]
//        return SubcategoriesViewModel(category: subcategory)
//    }
    
}
