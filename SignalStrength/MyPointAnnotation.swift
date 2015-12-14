//
//  MyPointAnnotation.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 14/12/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class MyPointAnnotation:MKPointAnnotation{
    
    var signalQuality:SignalQuality
    
    init(pSignalQuality:SignalQuality){
        self.signalQuality = pSignalQuality
    }

}