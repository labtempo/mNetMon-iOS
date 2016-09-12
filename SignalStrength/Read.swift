//
//  Readout.swift
//  Location
//
//  Created by Henrique do Prado Linhares on 18/11/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import RealmSwift

class Read: Object {

    dynamic var latitude:Double = 0.0
    dynamic var longitude:Double = 0.0
    dynamic var signalStrength:Double = 0.0
    dynamic var carrierName:String = ""
    
    func toString()->String{
        return "Read - Latitude: \(self.latitude) , Longitude: \(self.longitude) , Signal Strength: \(self.signalStrength) , Carrier name: \(self.carrierName)"
    }
    
}