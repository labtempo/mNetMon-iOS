//
//  Readout.swift
//  Location
//
//  Created by Henrique do Prado Linhares on 18/11/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import Foundation
import CoreLocation

class Read:NSObject, NSCoding{

    var ID:Int
    var location:CLLocation
    var signalStrength:Float
    var carrierName:String

    
    init(pID:Int, pLocation:CLLocation, pSignalStrength:Float, pCarrierName:String){
        self.ID = pID
        self.location = pLocation
        self.signalStrength = pSignalStrength
        self.carrierName = pCarrierName
    }
    
    
    func toString()->String{
    return "Read ID: \(self.ID) , Latitude: \(self.location.coordinate.latitude) , Longitude: \(self.location.coordinate.longitude) , Signal Strength: \(self.signalStrength) , Carrier name: \(self.carrierName)"
    }
    
    
    
    
    //NSCoding Methods
    required convenience init?(coder decoder: NSCoder) {
        
        
        guard let dID = decoder.decodeObjectForKey("ID") as? Int
            else {return nil }
        
        
        guard let dLocation = decoder.decodeObjectForKey("location") as? CLLocation
            else {return nil }
        
        
        guard let dSignalStrength = decoder.decodeObjectForKey("signalStrength") as? Float
            else {return nil }

        guard let dCarrierName = decoder.decodeObjectForKey("carrierName") as? String
            else {return nil }
        
        
        self.init(pID: dID, pLocation: dLocation, pSignalStrength: dSignalStrength, pCarrierName:dCarrierName)
        
    }
    
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.ID, forKey: "ID")
        coder.encodeObject(self.location, forKey: "location")
        coder.encodeObject(self.signalStrength, forKey: "signalStrength")
        coder.encodeObject(self.carrierName, forKey: "carrierName")
    }
    


}