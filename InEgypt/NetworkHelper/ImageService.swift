//
//  ImageService.swift
//  InEgypt
//
//  Created by Awady on 8/25/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit
import Nuke

class ImageService: UIViewController {
    
    class func downloadImage(withData data: String, imageView: UIImageView, givenCellSize: CGFloat? = nil, mode: UIView.ContentMode? = nil) {
        
        let activityIndicatorView: UIActivityIndicatorView = {
            let deviceType = UIDevice.current.deviceSize
            let style: UIActivityIndicatorView.Style = deviceType == .iPad ? .large : .medium
            let indecator = UIActivityIndicatorView(style: style)
            indecator.color = .systemGray
            indecator.startAnimating()
            indecator.hidesWhenStopped = true
            return indecator
        }()
        
        imageView.addSubview(activityIndicatorView)
        activityIndicatorView.anchorCenterSuperview()
        
        var cellSize: CGFloat = 250
        var successMode: UIView.ContentMode = .scaleAspectFill
        
        if givenCellSize != nil { cellSize = givenCellSize! }
        if mode != nil { successMode = mode! }
        
        var pixelSize: CGFloat {
            return cellSize * UIScreen.main.scale
        }
        
        var resizedImageProcessors: [ImageProcessing] {
          let imageSize = CGSize(width: pixelSize, height: pixelSize)
          return [ImageProcessors.Resize(size: imageSize, contentMode: .aspectFill)]
        }
        
        let contentModes = ImageLoadingOptions.ContentModes(
          success: successMode,
          failure: .center,
          placeholder: .center)

        ImageLoadingOptions.shared.placeholder = .none
        
        let imageConfigration = UIImage.SymbolConfiguration(pointSize: 50, weight: .medium, scale: .medium)
        let failureImage = UIImage(systemName: "icloud.slash", withConfiguration: imageConfigration)
        let failureImageTinted = failureImage?.withRenderingMode(.alwaysOriginal).withTintColor(.lightGray.withAlphaComponent(0.3))
        let placeholder = UIImage(systemName: "photo", withConfiguration: imageConfigration)
        let placeholderTinted = placeholder?.withRenderingMode(.alwaysOriginal).withTintColor(.lightGray.withAlphaComponent(0.3))
        ImageLoadingOptions.shared.failureImage = failureImageTinted
        ImageLoadingOptions.shared.placeholder = placeholderTinted
        ImageLoadingOptions.shared.transition = .fadeIn(duration: 0.6)
        ImageLoadingOptions.shared.contentModes = contentModes

        DataLoader.sharedUrlCache.diskCapacity = 0

        let pipeline = ImagePipeline {
          let dataCache = try? DataCache(name: "app.inegypt.photos.datacache")
          dataCache?.sizeLimit = 200 * 1024 * 1024
          $0.dataCache = dataCache
        }
        ImagePipeline.shared = pipeline
        
        
        guard let url = URL(string: data) else { return }
        let request = ImageRequest(url: url, processors: resizedImageProcessors)
        
        Nuke.loadImage(with: request, into: imageView) { result in
            activityIndicatorView.stopAnimating()
        }
    }
    
    class func downloadIcon(url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)?.withTintColor(.blue)
                else {
                completion(nil, error)
                return }
            DispatchQueue.main.async {
                completion(image, nil)
            }
        }.resume()
    }
}
