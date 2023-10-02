//
//  Constants.swift
//  Temper iOS Assignment
//
//  Created by Umur Yavuz on 01/10/2023.
//

import Foundation
import SwiftUI
import CoreLocation

var bottomSafeAreaHeight: CGFloat {
    if #available(iOS 11.0, *) {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        return window?.safeAreaInsets.bottom ?? 0
    } else {
        return 0
    }
}

var topSafeAreaHeight: CGFloat {
    if #available(iOS 11.0, *) {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        return window?.safeAreaInsets.top ?? 0
    } else {
        return 0
    }
}

// Amsterdam central coordinates
var myLocation: CLLocation = CLLocation(latitude: 52.379189, longitude: 4.899431)
