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
        title = "Black Star Wear"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let subcategoriesVC = segue.destination as! SubcategoriesTableViewController
        subcategoriesVC.viewModel = sender as? SubcategoriesViewModelProtocol
    }
}

extension CategoriesCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getNumberOfItems()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CategoryCollectionViewCell
        cell.viewModel = viewModel.getCellViewModel(at: indexPath)
        return cell
    }
}

extension CategoriesCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let subcategory = viewModel.getSubcategoryViewModel(at: indexPath)
    performSegue(withIdentifier: segueIdentifier, sender: subcategory)
    }
}

extension CategoriesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 32, height: 100)
    }
}




