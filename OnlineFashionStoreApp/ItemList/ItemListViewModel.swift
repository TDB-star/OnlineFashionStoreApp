//
//  ItemListViewModel.swift
//  OnlineFashionStoreApp
//
//  Created by Tatiana Dmitrieva on 15/01/2022.
//

import Foundation


protocol ItemListViewModelProtocol {
    
    var items: [Product] { get }
    var itemUrl: String { get }
    var subcategory: Subcategory { get }
    var navigationBarTitle: String { get }
    init(items: Subcategory)
    
    func fetchItems(completion: @escaping() -> Void)
    func getNumberOfItems() -> Int
    func getItemListCellViewModel(at indexPath: IndexPath) -> ItemListCellViewModelProtocol
    //func getItemDetailsViewModel(at indexPath: IndexPath) -> ItemDetailsViewModelProtocol
}

class ItemListViewModel: ItemListViewModelProtocol {

    var items: [Product] = []
    
    var itemUrl: String {
        URLS.products.rawValue+subcategory.id.stringValue!
    }
    
    let subcategory: Subcategory
    var navigationBarTitle: String {
        subcategory.name
    }
    
    required init(items: Subcategory) {
        self.subcategory = items
    }
    
    func fetchItems(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchItemData(url: itemUrl) { items in
            self.items = items
            completion()
        }
    }
    
    func getNumberOfItems() -> Int {
        return items.count
    }
    
    func getItemListCellViewModel(at indexPath: IndexPath) -> ItemListCellViewModelProtocol {
        let items = items[indexPath.row]
        return ItemListCellViewModel(item: items)
    }
    
//    func getItemDetailsViewModel(at indexPath: IndexPath) -> ItemDetailsViewModelProtocol {
//        let item = items[indexPath.row]
//        return ItemDetailsViewModel(itemDitails: item)
//    }
}
