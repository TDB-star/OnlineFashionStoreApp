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

}
