//
//  ItemDetailsViewController.swift
//  OnlineFashionStoreApp
//
//  Created by Tatiana Dmitrieva on 15/01/2022.
//

import UIKit

class ItemDetailsViewController: UIViewController {

    private let cellIdentifier = "ItemDetailsPhotoCell"
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var sizeTextField: UITextField!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
       
    }
    
    @IBAction func addToCartButtonPressed(_ sender: UIButton) {
    }
}

extension ItemDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PhotoGalaryCollectionViewCell
        return cell
    }
}

extension ItemDetailsViewController: UICollectionViewDelegate {
    
}
