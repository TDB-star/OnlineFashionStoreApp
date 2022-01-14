//
//  CategoriesViewController.swift
//  OnlineFashionStoreApp
//
//  Created by Tatiana Dmitrieva on 12/01/2022.
//

import UIKit

class CategoriesCollectionViewController: UICollectionViewController {

    private let cellIdentifier = "CategoryCell"
    private let segueIdentifier = "ToSabcategoryViewController"
    
    private var viewModel: CategoryViewModelProtocol! {
        didSet {
            viewModel.fetchData {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = CategoryListViewModel()
    }
}

extension CategoriesCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getNumberOfRows()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CategoryCollectionViewCell
        cell.viewModel = viewModel.getCellViewModel(at: indexPath)
        return cell
    }
}

extension CategoriesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 100)
    }
}




