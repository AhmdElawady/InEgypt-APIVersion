//
//  BaseAlert.swift
//  InEgypt
//
//  Created by Awady on 6/21/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import UIKit

class Alert {
    
    static func show(title: String, message: String, vc: UIViewController, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok".localized, style: .default, handler: handler))
        vc.present(alert, animated: true, completion: nil)
    }
    
    private static func alertWithAction(title: String, message: String, actionTitle: String, vc: UIViewController, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .destructive, handler: handler))
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
   
//    static func addReviewfieldMissingAlert(on vc: UIViewController) {
//        show(title: "Incomplete Form".localized, message: "Please fill missing field: /n/n - Add at least one star /n/n - Add your name /n/n - Write your comment".localized, vc: vc, handler: nil)
//    }
    
    
    static func locationDisabledAlert(on vc: UIViewController) {
        alertWithAction(title: "Location Disabled".localized, message: "EnableLocationDescription".localized, actionTitle: "Enable".localized, vc: vc) { action in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)")
                })
            }
        }
    }
    
    
}
