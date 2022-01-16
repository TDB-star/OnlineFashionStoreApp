//
//  PhotosGalaryTableViewCell.swift
//  OnlineFashionStoreApp
//
//  Created by Tatiana Dmitrieva on 15/01/2022.
//

import UIKit

class PhotoGalaryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemImageView: CustomImageView!
    
    var viewModel: ItemPhotoCarouselCellViewModelProtocol! {
        didSet {
            itemImageView.fetchImage(from: viewModel.imageUrl)
            itemImageView.clipsToBounds = true
            itemImageView.contentMode = .scaleAspectFill
        }
    }
    
}
