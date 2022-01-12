//
//  CategoriesViewController.swift
//  OnlineFashionStoreApp
//
//  Created by Tatiana Dmitrieva on 12/01/2022.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
   
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
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel = CategoryListViewModel()
        
        collectionView.collectionViewLayout = createLayout()
        

    }
}

extension CategoriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getNumberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CategoryCollectionViewCell
        cell.viewModel = viewModel.getCellViewModel(at: indexPath)
        return cell
    }
}

extension CategoriesViewController: UICollectionViewDelegate {
    
}

extension CategoriesViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
 
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
                        
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(86))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .flexible(2)
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
            
            return section
        }
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        layout.configuration = configuration
        
        return layout
    }
}

