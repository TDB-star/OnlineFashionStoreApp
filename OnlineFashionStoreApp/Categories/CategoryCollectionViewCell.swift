//
//  CategoryCollectionViewCell.swift
//  OnlineFashionStoreApp
//
//  Created by Tatiana Dmitrieva on 12/01/2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    var viewModel: CategoryCellViewModelProtocol! {
        didSet {
        nameLabel.text = viewModel.categoryName

            //categoryImageView.fetchImage(from: viewModel.imageUrl)
                       guard let imageData = viewModel.imageData else { return }
                      categoryImageView.image = UIImage(data: imageData)
            categoryImageView.layer.cornerRadius = categoryImageView.frame.size.width / 2
            categoryImageView.clipsToBounds = true
            categoryImageView.contentMode = .scaleAspectFill
            
        }
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        categoryImageView.image = nil
//    }
}
