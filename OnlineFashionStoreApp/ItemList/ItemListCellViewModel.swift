//
//  ItemListCellViewModel.swift
//  OnlineFashionStoreApp
//
//  Created by Tatiana Dmitrieva on 15/01/2022.
//

import Foundation


protocol ItemListCellViewModelProtocol {
    var name: String { get }
    var price: String { get }
    var imageData: Data? { get }
    var imageUrl: String { get }
    
    init(item: Product)
}

class ItemListCellViewModel: ItemListCellViewModelProtocol {
    var name: String {
        item.name ?? ""
    }
    
    var price: String {
        item.price
    }
    
    var imageData: Data? {
        ImageManager.shared.fetchImageData(from: imageUrl)
    }
    
    var imageUrl: String {
        URLS.stringPath.rawValue+item.mainImage!
    }
    
    private var item: Product
    
    required init(item: Product) {
        self.item = item
    }
    
}
