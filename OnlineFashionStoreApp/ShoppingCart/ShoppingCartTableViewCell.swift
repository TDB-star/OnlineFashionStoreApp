//
//  ShoppingCartTableViewCell.swift
//  OnlineFashionStoreApp
//
//  Created by Tatiana Dmitrieva on 16/01/2022.
//

import UIKit

class ShoppingCartTableViewCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    func cofigure(with model: SelectedItem) {
        nameLabel.text = model.itemName
        priceLabel.text = "\((model.itemPrice as NSString?)?.intValue ?? 0) ₽"
        colorLabel.text = model.itemColor
        sizeLabel.text = model.itemSize
        guard let imageData = model.Image else { return }
        itemImageView.image = UIImage(data: imageData)
        itemImageView.clipsToBounds = true
        itemImageView.contentMode = .scaleAspectFill
    }


}
