//
//  NetworkManager.swift
//  OnlineFashionStoreApp
//
//  Created by Tatiana Dmitrieva on 12/01/2022.
//

import Foundation


enum URLS: String {
   case stringURLcategories = "https://blackstarshop.ru/index.php?route=api/v1/categories"
   case stringPath = "https://blackstarshop.ru/"
   case products = "https://blackstarshop.ru/index.php?route=api/v1/products&cat_id="
    
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(completion: @escaping (_ categories: [Category]) -> Void) {
        guard let url = URL(string: URLS.stringURLcategories.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No description")
                return
            }
            do {
              let decoder = JSONDecoder()
                let categories = try decoder.decode(CategoriesArray.self, from: data)
                let filteredArray = categories.array.filter({$0.image != ""})
                    .sorted {$0.name < $1.name}
                    .filter({$0.name != "Предзаказ"})
                
                DispatchQueue.main.async {
                    completion(filteredArray)
                }
            }
            catch let error {
                print("Error serialization json", error)
            }
        }.resume()
    }
    
    func fetchItemData(url: String?, with completion: @escaping (_ items: [Product]) -> Void ) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
       
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error, let response = response  {
                print(error, response)
                print(url)
                return
            }
            guard let data = data else {
                print(error?.localizedDescription ?? "no description")
                return
            }
            do {
                let products = try JSONDecoder().decode(ProductValueArray.self, from: data)
                let items = products.array
                DispatchQueue.main.async {
                   completion(items)
                }
            }
            catch let error {
                print(error)
            }
        } .resume()
    }
}
