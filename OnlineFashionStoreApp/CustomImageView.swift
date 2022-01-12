//
//  CustomImageView.swift
//  OnlineFashionStoreApp
//
//  Created by Tatiana Dmitrieva on 12/01/2022.
//

import UIKit

class CustomImageView: UIImageView {
    
    func fetchImage(from url: String) {
        guard let imageURL = URL(string: url) else {
            image = UIImage(systemName: "eye")
            return
        }
        // Берём изображение из кэша, если оно там есть
        
        if let cachedImage = getCachedImage(from: imageURL) {
            image = cachedImage
            return
        }
        // если изображения нет, то загружаем из сети
        
        ImageManager.shared.fetchImageDataToCache(from: imageURL) { data, response in
            self.image = UIImage(data: data)
            
        // сохраняем изображение в кэш
            
            self.saveDataToCache(with: data, and: response)
        }
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        
        let cachedResponse = CachedURLResponse(response: response, data: data)
        guard let url = response.url else { return }
        let request = URLRequest(url: url)
        
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
    
    private func getCachedImage(from url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
}
