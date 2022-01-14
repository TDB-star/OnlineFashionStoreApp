//
//  SubcategoryTableViewCell.swift
//  OnlineFashionStoreApp
//
//  Created by Tatiana Dmitrieva on 14/01/2022.
//

import UIKit

class SubcategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var viewModel: SubcategoryCellViewModelProtocol! {
        didSet {
            nameLabel.text = viewModel.subcategoryName
        }
    }
}
