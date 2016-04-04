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

class Read:NSObject, NSCoding{

    var latitude:Double
    var longitude:Double
    var signalStrength:SignalStrengthValue
    var carrierName:String
    
    init(pLatitude:Double, pLongitude:Double, pSignalStrength:SignalStrengthValue, pCarrierName:String){
        
        self.latitude = pLatitude
        self.longitude = pLongitude
 
        self.signalStrength = pSignalStrength
        self.carrierName = pCarrierName
    }
    
    func toString()->String{
    return "Read - Latitude: \(self.latitude) , Longitude: \(self.longitude) , Signal Strength: \(self.signalStrength.signalValue.description) , Carrier name: \(self.carrierName)"
    }
    
    //Beginning of NSCoding Methods
    required convenience init?(coder decoder: NSCoder) {
        
      
        guard let dLatitude = decoder.decodeObjectForKey("latitude") as? Double
            else {return nil }
      
        guard let dLongitude = decoder.decodeObjectForKey("longitude") as? Double
            else {return nil }
        
        guard let dSignalStrength = decoder.decodeObjectForKey("signalStrength") as? SignalStrengthValue
            else {return nil }

        guard let dCarrierName = decoder.decodeObjectForKey("carrierName") as? String
            else {return nil }
        
        
        self.init(pLatitude:dLatitude, pLongitude:dLongitude, pSignalStrength: dSignalStrength, pCarrierName:dCarrierName)
    }
    
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.latitude, forKey: "latitude")
        coder.encodeObject(self.longitude, forKey: "longitude")
        coder.encodeObject(self.signalStrength, forKey: "signalStrength")
        coder.encodeObject(self.carrierName, forKey: "carrierName")
    }
    //End of NSCoding Methods

}