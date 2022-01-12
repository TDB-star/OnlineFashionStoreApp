//
//  Models.swift
//  OnlineFashionStoreApp
//
//  Created by Tatiana Dmitrieva on 12/01/2022.
//

// MARK: Get Category and Subcategory Data model

struct CategoriesArray: Codable {
   var array: [Category]

   private struct DynamicCodingKeys: CodingKey {
       var stringValue: String
       var intValue: Int?
       
       init?(stringValue: String) {
           self.stringValue = stringValue
       }
       
       init?(intValue: Int) {
           return nil
       }
   }
       init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
           var tempArray = [Category]()
           
           for key in container.allKeys {
               let decodedObject = try container.decode(Category.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
               tempArray.append(decodedObject)
           }
           array = tempArray
       }
   }

struct Category: Codable {
    let name: String
    let sortOrder: SortOrder
    let image, iconImage, iconImageActive: String?
    let subcategories: [Subcategory]
}

enum SortOrder: Codable {
    case integer(Int)
    case string(String)
    
    var stringValue: String? {
            if case .string(let str) = self {
                return str
            }
            return nil
        }
    var intValue: Int? {
            if case .integer(let int) = self {
                return int
            }
            return nil
        }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(SortOrder.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for SortOrder"))
    }
}

struct Subcategory: Codable {
    let id: SortOrder
    let iconImage: String
    let sortOrder: SortOrder
    let name: String
    let type: TypeEnum
}

enum TypeEnum: String, Codable {
    case category = "Category"
    case collection = "Collection"
}

// MARK: Get Item Data Model

struct ProductValueArray: Codable {
   var array: [Product]

   private struct DynamicCodingKeys: CodingKey {
       var stringValue: String
       var intValue: Int?

       init?(stringValue: String) {
           self.stringValue = stringValue
       }

       init?(intValue: Int) {
           return nil
       }
   }
       init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
           var tempArray = [Product]()

           for key in container.allKeys {
               let decodedObject = try container.decode(Product.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
               tempArray.append(decodedObject)
           }
           array = tempArray
       }
   }

struct Product: Codable {
    let name, englishName, article: String?
    let sortOrder: SortOrder
    let productDescription, colorName, colorImageURL, mainImage: String?
    let productImages: [ProductImage]
    let offers: [Offer]
    let price: String
    let tag: String?

    enum CodingKeys: String, CodingKey {
        case name, englishName, sortOrder, article
        case productDescription = "description"
        case colorName, colorImageURL, mainImage, productImages, offers, price, tag
    }
}

struct Offer: Codable {
    var size, productOfferID, quantity: String
}

struct ProductImage: Codable {
    let imageURL: String
    let sortOrder: SortOrder
}
