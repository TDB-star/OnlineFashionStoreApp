//
//  SubcategoriesTableViewController.swift
//  OnlineFashionStoreApp
//
//  Created by Tatiana Dmitrieva on 14/01/2022.
//

import UIKit

class SubcategoriesTableViewController: UITableViewController {
    private let cellIdentifier = "SubcategoryCell"
    private let segueIdentifier = "ToItemsListViewController"
    
    var viewModel: SubcategoriesViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.navigationBarTitle
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.getNumberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SubcategoryTableViewCell
        cell.viewModel = viewModel.getCellViewModel(at: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "ItemViewController") as! ItemListCollectionViewController
        
        let subcategoryItems = viewModel.getItemListViewModel(at: indexPath)
        vc.viewModel = subcategoryItems
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "Main", bundle: .main)
//        let viewController = storyboard.instantiateViewController(identifier: "productVC") as! ProductListViewController
//
//        viewController.categoryId = subcategories[indexPath.row].id
//        viewController.categoryName = subcategories[indexPath.row].name
//
//        navigationController?.pushViewController(viewController, animated: true)
//        tableView.deselectRow(at: indexPath, animated: true)
//    }

}
