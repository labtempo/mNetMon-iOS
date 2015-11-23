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

    
    init(pID:Int, pLocation:CLLocation, pSignalStrength:Float){
        self.ID = pID
        self.location = pLocation
        self.signalStrength = pSignalStrength
    }
    
    
    func toString()->String{
    return "Read ID: \(self.ID) , Latitude: \(self.location.coordinate.latitude) , Longitude: \(self.location.coordinate.longitude) , Signal Strength: \(self.signalStrength)"
    }
    
    
    
    
    //NSCoding Methods
    required convenience init?(coder decoder: NSCoder) {
        
        
        guard let dID = decoder.decodeObjectForKey("ID") as? Int
            else {return nil }
        
        
        guard let dLocation = decoder.decodeObjectForKey("location") as? CLLocation
            else {return nil }
        
        
        
        guard let dSignalStrength = decoder.decodeObjectForKey("signalStrength") as? Float
            else {return nil }
        
        
        self.init(pID: dID, pLocation: dLocation, pSignalStrength: dSignalStrength)
        
        
        
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.ID, forKey: "ID")
        coder.encodeObject(self.location, forKey: "location")
        coder.encodeObject(self.signalStrength, forKey: "signalStrength")
    }
    


}