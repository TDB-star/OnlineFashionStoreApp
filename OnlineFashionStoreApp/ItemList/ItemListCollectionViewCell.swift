//
//  ItemListCollectionViewCell.swift
//  OnlineFashionStoreApp
//
//  Created by Tatiana Dmitrieva on 15/01/2022.
//

import UIKit

class ItemListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: CustomImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var viewModel: ItemListCellViewModelProtocol! {
        didSet {
            itemImageView.fetchImage(from: viewModel.imageUrl)
            itemImageView.clipsToBounds = true
            itemImageView.contentMode = .scaleAspectFill
            nameLabel.text = viewModel.name
            priceLabel.text = "\((viewModel.price as NSString?)?.intValue ?? 0) ₽"
        }
    }
}
