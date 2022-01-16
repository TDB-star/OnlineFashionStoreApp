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
    
    var viewModel: ItemDetailsViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = configureCollectionViewLayout()
        setUpUI()
        addToCartButton.layer.cornerRadius = 4
        addToCartButton.layer.cornerCurve = .continuous
       
    }
    
    @IBAction func addToCartButtonPressed(_ sender: UIButton) {
    }
    
    private func setUpUI() {
        nameLabel.text = viewModel.itemName
        priceLabel.text = "\((viewModel.itemPrice as NSString?)?.intValue ?? 0) ₽"
        colorLabel.text = viewModel.itemColor
        descriptionLabel.text = viewModel.itemDescription
        sizeTextField.setRightView(image: "chevron.down")
        sizeTextField.tintColor = .clear
        sizeTextField.loadDropdownData(data: viewModel.getArrayOfSizes())
    }
}

extension ItemDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getItemPhotos()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PhotoGalaryCollectionViewCell
        cell.viewModel = viewModel.getItemPhotoCarouselCellViewModel(at: indexPath)
        return cell
    }
}

extension ItemDetailsViewController: UICollectionViewDelegate {
    
}

extension ItemDetailsViewController {
    
    func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize (
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize (
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.interGroupSpacing = 2
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
