//
//  CustomAnnotation.swift
//  InEgypt
//
//  Created by Awady on 10/22/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import MapKit


class CustomAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let distance: Double?
    let discepline: String?
    let coordinate: CLLocationCoordinate2D
    let poster: String?
    let categoryId: String?
    let identifier = "pin"
    
    init(title: String, distance: Double?, discepline: String, coordinate: CLLocationCoordinate2D, poster: String?, categoryId: String?) {
        self.title = title
        self.distance = distance
        self.discepline = discepline
        self.coordinate = coordinate
        self.poster = poster
        self.categoryId = categoryId
        
        super.init()
    }
    
    var subtitle: String? {
        if distance == nil {
            return ""
        } else {
            return String(format: "%.2f", distance ?? 0.0)+" km".localized
        }
    }
    
    var categoryIcon: UIImage {
        var iconImage = UIImage()
        let url = URL(string: categoryId ?? "")
        ImageService.downloadIcon(url: url!) { image, error in
            if let image = image {
                iconImage = image
            }
        }
        return iconImage
    }
    
    var markerTintColor: UIColor {
        switch discepline {
        case "0":
            return #colorLiteral(red: 0.9983811975, green: 0.3601943254, blue: 0.2774392366, alpha: 1)
        case "1":
            return #colorLiteral(red: 0.880125165, green: 0.6720394492, blue: 0.09084091336, alpha: 1)
        case "transport":
            return .blue
        default:
            return .black
        }
    }
    
}
