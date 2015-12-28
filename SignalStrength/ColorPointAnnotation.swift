//
//  ColorPointAnnotation.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 28/12/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import Foundation
import MapKit

class ColorPointAnnotation: MKPointAnnotation {
    var pinColor: UIColor
    
    init(pinColor: UIColor) {
        self.pinColor = pinColor
        super.init()
    }
    
}