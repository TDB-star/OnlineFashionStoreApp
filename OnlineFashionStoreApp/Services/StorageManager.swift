//
//  StorageManager.swift
//  OnlineFashionStoreApp
//
//  Created by Tatiana Dmitrieva on 12/01/2022.
//

import RealmSwift

class SelectedItem: Object {
    @objc dynamic var Image: Data?
    @objc dynamic var itemName: String = ""
    @objc dynamic var itemSize: String = ""
    @objc dynamic var itemColor: String = ""
    @objc dynamic var itemPrice: String = ""
}

class StorageManager {
    static let shared = StorageManager()
    
    let realm = try! Realm()
    
    private init() {}
    
    func write(_ product: Any) {
        try! realm.write{
            realm.add(product as! Object)
        }
    }
    
    func delete(_ product: SelectedItem) {
        try! realm.write{
            realm.delete(product)
        }
    }
    
    func read() -> Results<SelectedItem>? {
        let array = realm.objects(SelectedItem.self)
        return array
    }
    
    func read(completion: @escaping (_ items: Results<SelectedItem>) -> Void)  {
        let array = realm.objects(SelectedItem.self)
        completion(array)
        
    }
}
