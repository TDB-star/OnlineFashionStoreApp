//
//  ItemDetailsViewModel.swift
//  OnlineFashionStoreApp
//
//  Created by Tatiana Dmitrieva on 15/01/2022.
//

import Foundation

protocol ItemDetailsViewModelProtocol {
    var selectedItem: SelectedItem { get }
    var itemName: String { get }
    var itemPrice: String { get }
    var itemColor: String { get }
    var itemDescription: String { get }
    var itemMainImageData: Data? { get }
    var imageUrl: String { get }
   
    init(itemDitails: Product)
    
    func getItemPhotos() -> Int
    func getArrayOfSizes() -> [String]
    func getItemPhotoCarouselCellViewModel(at indexPath: IndexPath) -> ItemPhotoCarouselCellViewModelProtocol
    func getSelectedItem(size: String) //-> SelectedItem
   
}

class ItemDetailsViewModel: ItemDetailsViewModelProtocol {

    var selectedItem = SelectedItem()

    var itemName: String {
        item.name ?? ""
    }
    
    var itemPrice: String {
        item.price
    }
    
    var itemColor: String {
        item.colorName ?? ""
    }
    
    var itemDescription: String {
        item.productDescription ?? "Нет описания"
    }
    
    var imageUrl: String {
        URLS.stringPath.rawValue+item.mainImage!
    }
    
    var itemMainImageData: Data? {
        ImageManager.shared.fetchImageData(from: imageUrl)
    }

    private let item: Product
    
    required init(itemDitails: Product) {
        item = itemDitails
    }
    
    func getItemPhotos() -> Int {
        item.productImages.count
    }
    
    func getArrayOfSizes() -> [String] {
        let array = item.offers.map({$0.size})
        return array
    }
    
    func getItemPhotoCarouselCellViewModel(at indexPath: IndexPath) -> ItemPhotoCarouselCellViewModelProtocol {
        let photos = item.productImages[indexPath.item]
        return ItemPhotoCarouselCellViewModel(image: photos)
    }
    
     func getSelectedItem(size: String) {
        selectedItem.itemName = item.name ?? ""
        selectedItem.itemColor = item.colorName ?? ""
        selectedItem.itemPrice = item.price
        selectedItem.Image = itemMainImageData
        selectedItem.itemSize = size
        StorageManager.shared.write(selectedItem)
    }
}
