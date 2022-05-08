//
//  ImageLoader.swift
//  Exam
//
//  Created by Carlos Caraccia on 08/05/2022.
//

import UIKit

 let _imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoader:UIImageView {
    
    var imageURL:URL?
    var isLoading = false
    
    var imageCache = _imageCache
    
    let activityIndicator = UIActivityIndicatorView()
    
    func loadImage(with url: URL) {
        activityIndicator.color = .darkGray

        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        imageURL = url

        image = nil
        activityIndicator.startAnimating()
        
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
              self.image = imageFromCache
              activityIndicator.stopAnimating()
              return
          }
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else {
                    return
                }
                self.imageCache.setObject(image, forKey: url.absoluteString as AnyObject)
                DispatchQueue.main.async {
                    self.image = image
                    self.activityIndicator.stopAnimating()
                }
            } catch {
                print(error)
            }
        }
    }
}


