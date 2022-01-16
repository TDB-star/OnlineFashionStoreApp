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
    private var choisenSize = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = configureCollectionViewLayout()
        setUpUI()
    }
    
    @IBAction func addToCartButtonPressed(_ sender: UIButton) {
        
        if sizeTextField.text == "" {
            let alert = UIAlertController(title: "Пожалуйста, выберете размер", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Выбрать размер", style: .default))
            alert.addAction(UIAlertAction(title: "Закрыть", style: .default))
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            choisenSize = sizeTextField.text ?? ""
            viewModel.getSelectedItem(size: choisenSize)
            
            let alert = UIAlertController(title: "Товар успешно добавлен в корзину", message: "", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Перейти в корзину", style: .default, handler: { [weak self] _ in
                let dest = self?.storyboard?.instantiateViewController(withIdentifier: "ShoppingCatViewController") as! ShoppingCartViewController
                self?.navigationController?.pushViewController(dest, animated: true)
            }))
            
            alert.addAction(UIAlertAction(title: "Продолжить покупки", style: .default, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func setUpUI() {
        addToCartButton.layer.cornerRadius = 4
        addToCartButton.layer.cornerCurve = .continuous
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
