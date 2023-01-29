//
//  Devices.swift
//  InEgypt
//
//  Created by Awady on 8/12/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import UIKit

extension UIDevice {
    
    enum DeviceType: String {
        case iPhones_SE_6_7_8
        case iPhones_X_11_12
        case iPhones_Plus_Max
        case iPhone
        case iPad
        case unknown
    }
    
    var deviceType: DeviceType {
        switch UIScreen.main.nativeBounds.width {
        case 750, 640:
            return .iPhones_SE_6_7_8
        case 1170, 1125, 828:
            return .iPhones_X_11_12
        case 1284, 1242, 1080:
            return .iPhones_Plus_Max
        case 2048, 1640, 1620, 1536, 1668:
            return .iPad
        default:
            return .unknown
        }
    }
    
    var deviceSize: DeviceType {
        switch UIScreen.main.nativeBounds.width {
        case 1284, 1242, 1080, 1170, 1125, 828, 750, 640:
            return .iPhone
        case 2048, 1640, 1620, 1536, 1668:
            return .iPad
        default:
            return .unknown
        }
    }
}
