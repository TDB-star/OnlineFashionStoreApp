//
//  ItemPhotoCellViewModel.swift
//  OnlineFashionStoreApp
//
//  Created by Tatiana Dmitrieva on 15/01/2022.
//

import Foundation

protocol ItemPhotoCarouselCellViewModelProtocol {
    
    var imageData: Data? { get }
    var imageUrl: String { get }
    
    init(image: ProductImage)
}

class ItemPhotoCarouselCellViewModel: ItemPhotoCarouselCellViewModelProtocol {
   
    var imageUrl: String {
        URLS.stringPath.rawValue+image.imageURL
    }
    
    var imageData: Data? {
        ImageManager.shared.fetchImageData(from: imageUrl)
    }
    
    private var image: ProductImage
    
    required init(image: ProductImage) {
        self.image = image
    }
}
