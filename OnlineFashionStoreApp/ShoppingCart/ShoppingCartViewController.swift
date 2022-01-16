//
//  ShoppingCartViewController.swift
//  OnlineFashionStoreApp
//
//  Created by Tatiana Dmitrieva on 12/01/2022.
//

import UIKit

class ShoppingCartViewController: UIViewController {
    private var cellIdentifier = "ShoppingCartCell"
    
    @IBOutlet weak var numberOfItemsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var footerView: UIView!
    
    private var allItems: [SelectedItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = footerView
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getItemsFromDataBase()
    }
    
    @IBAction func toggleEditButton(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:
                                                                (tableView.isEditing) ? .close : .trash,
                                         target: self,
                                         action: #selector(toggleEditButton))
    }
}

extension ShoppingCartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ShoppingCartTableViewCell
        let item = allItems[indexPath.row]
        cell.cofigure(with: item)
        return cell
    }
}

extension ShoppingCartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let itemToDelete = allItems[indexPath.row]
            allItems.remove(at: indexPath.row)
            StorageManager.shared.delete(itemToDelete)
            getItemsFromDataBase()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        80
    }
}

extension ShoppingCartViewController {
    private func getItemsFromDataBase() {
        StorageManager.shared.read { items in
            self.allItems = Array(items)
            self.updateTotalLabels(false)
            self.tableView.reloadData()
        }
    }
    
    private func updateTotalLabels(_ isEmpty: Bool) {
        if isEmpty {
            numberOfItemsLabel.text = "0"
            totalPriceLabel.text = calculateTotalPrice()
        } else {
            numberOfItemsLabel.text = "\(allItems.count)"
            totalPriceLabel.text = calculateTotalPrice()
        }
    }
    
    private func calculateTotalPrice() -> String {
        var totalPrice = 0
        
        for item in allItems {
            totalPrice += (item.itemPrice as NSString).integerValue
        }
        return "Итого: \(totalPrice) ₽"
    }
}
