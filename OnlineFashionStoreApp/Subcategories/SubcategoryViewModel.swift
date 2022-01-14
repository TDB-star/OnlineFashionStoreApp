//
//  SubcategoryViewModel.swift
//  OnlineFashionStoreApp
//
//  Created by Tatiana Dmitrieva on 14/01/2022.
//

import Foundation

protocol SubcategoriesViewModelProtocol {
    
    var category: Category { get }
    var navigationBarTitle: String { get }
   
    init(category: Category)
    
    func getNumberOfRows() -> Int
    func getItemsURL(at indexPath: IndexPath) -> String
    func getCellViewModel(at indexPath: IndexPath) -> SubcategoryCellViewModelProtocol
   // func getItemsListViewModel(at indexPath: IndexPath) -> ItemsListViewModelProtocol
    
}

class SubcategoriesViewModel: SubcategoriesViewModelProtocol {

    var category: Category
    
    var navigationBarTitle: String {
        category.name
    }
    
    required init(category: Category) {
        self.category = category
    }
    
    func getNumberOfRows() -> Int {
        category.subcategories.count
    }

    func getItemsURL(at indexPath: IndexPath) -> String {
        let stringURL = URLS.stringPath.rawValue
        let itemId = category.subcategories[indexPath.row].id
        let itemUrl = stringURL + itemId.stringValue!
        return itemUrl
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> SubcategoryCellViewModelProtocol {
         let subcategory = category.subcategories[indexPath.row]
        return SubcategoryCellViewModel(subcategory: subcategory)
    }
    
//    func getItemsListViewModel(at indexPath: IndexPath) -> ItemsListViewModelProtocol {
//        let itemsID = category.subcategories[indexPath.row]
//        return ItemsListViewModel(items: itemsID)
//    }
}
