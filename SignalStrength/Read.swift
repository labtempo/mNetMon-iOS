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

    var ID:Int
    var latitude:Double
    var longitude:Double
    var signalStrength:SignalStrengthValue
    var carrierName:String
    
    init(pID:Int, pLatitude:Double, pLongitude:Double, pSignalStrength:SignalStrengthValue, pCarrierName:String){
        self.ID = pID
        
        let latitudeINT = (Int(pLatitude / 0.002))
        let qLatitude = Double(latitudeINT) * 0.002
        
        let longitudeINT = (Int(pLongitude / 0.002))
        let qLongitude = Double(longitudeINT) * 0.002
        
        self.latitude = qLatitude
        self.longitude = qLongitude
 
        self.signalStrength = pSignalStrength
        self.carrierName = pCarrierName
    }
    
    func toString()->String{
    return "Read ID: \(self.ID) , Latitude: \(self.latitude) , Longitude: \(self.longitude) , Signal Strength: \(self.signalStrength.signalValue.description) , Carrier name: \(self.carrierName)"
    }
    
    //Beginning of NSCoding Methods
    required convenience init?(coder decoder: NSCoder) {
        
        guard let dID = decoder.decodeObjectForKey("ID") as? Int
            else {return nil }
        
        guard let dLatitude = decoder.decodeObjectForKey("latitude") as? Double
            else {return nil }
      
        guard let dLongitude = decoder.decodeObjectForKey("longitude") as? Double
            else {return nil }
        
        guard let dSignalStrength = decoder.decodeObjectForKey("signalStrength") as? SignalStrengthValue
            else {return nil }

        guard let dCarrierName = decoder.decodeObjectForKey("carrierName") as? String
            else {return nil }
        
        
        self.init(pID: dID, pLatitude:dLatitude, pLongitude:dLongitude, pSignalStrength: dSignalStrength, pCarrierName:dCarrierName)
    }
    
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.ID, forKey: "ID")
        coder.encodeObject(self.latitude, forKey: "latitude")
        coder.encodeObject(self.longitude, forKey: "longitude")
        coder.encodeObject(self.signalStrength, forKey: "signalStrength")
        coder.encodeObject(self.carrierName, forKey: "carrierName")
    }
    //End of NSCoding Methods

}