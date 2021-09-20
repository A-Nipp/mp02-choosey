//
//  UrlImageView.swift
//  NewsApp
//
//  Created by SchwiftyUI on 12/29/19.
//  Copyright © 2019 SchwiftyUI. All rights reserved.
//

import SwiftUI

struct URLImage: View {
    @ObservedObject var urlImageModel: Model
    
    init(urlString: String?) {
        urlImageModel = Model(urlString: urlString)
    }
    
    var body: some View {
        if let image = urlImageModel.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
        } else {
            Image(uiImage: URLImage.defaultImage)
                .renderingMode(.template)
                .font(.largeTitle)
                .foregroundColor(.secondary)
        }
    }
    
    static var defaultImage = UIImage(systemName: "photo")!
}

extension URLImage {
    class Model: ObservableObject {
        @Published var image: UIImage?
        
        var urlString: String?
        var imageCache = ImageCache.shared
    
        init(urlString: String?) {
            self.urlString = urlString
            loadImage()
        }
    
        func loadImage() {
            if loadImageFromCache() {
                return
            }
        
            loadImageFromUrl()
        }
    
        func loadImageFromCache() -> Bool {
            guard let urlString = urlString else {
                return false
            }
        
            guard let cacheImage = imageCache.get(forKey: urlString) else {
                return false
            }
        
            image = cacheImage
            return true
        }
    
        func loadImageFromUrl() {
            guard let urlString = urlString, let url = URL(string: urlString) else {
                return
            }
        
            let task = URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponse(data:response:error:))
            task.resume()
        }
    
        func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
            guard error == nil else {
                print("Error: \(error!)")
                return
            }
            guard let data = data else {
                print("No data found")
                return
            }
        
            DispatchQueue.main.async {
                guard let loadedImage = UIImage(data: data) else {
                    return
                }
            
                self.imageCache.set(forKey: self.urlString!, image: loadedImage)
                self.image = loadedImage
            }
        }
    }

    class ImageCache {
        static var shared = ImageCache()

        var cache = NSCache<NSString, UIImage>()
    
        func get(forKey: String) -> UIImage? {
            return cache.object(forKey: NSString(string: forKey))
        }
    
        func set(forKey: String, image: UIImage) {
            cache.setObject(image, forKey: NSString(string: forKey))
        }
    }
}

extension URLImage.ImageCache {
}
