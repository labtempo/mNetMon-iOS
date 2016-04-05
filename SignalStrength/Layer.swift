//
//  Layer.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 04/04/16.
//  Copyright © 2016 Henrique do Prado Linhares. All rights reserved.
//

import Foundation

class Layer:NSObject, NSCoding{
    
    var ID:Int
    var minDelta:Double
    var maxDelta:Double
    var precisionCoeficient:Double
    var reads:[Read]

    init(pID: Int, pMinDelta:Double, pMaxDelta:Double, pPrecisionCoeficient:Double, pReads:[Read]){
        self.ID = pID
        self.minDelta = pMinDelta
        self.maxDelta = pMaxDelta
        self.precisionCoeficient = pPrecisionCoeficient
        self.reads = pReads
    }


    init(pID: Int, pMinDelta:Double, pMaxDelta:Double, pPrecisionCoeficient:Double){
        self.ID = pID
        self.minDelta = pMinDelta
        self.maxDelta = pMaxDelta
        self.precisionCoeficient = pPrecisionCoeficient
        self.reads = [Read]()
    }
    
    func addRead(pRead:Read){
        
        var paramRead = Read(pLatitude: pRead.latitude, pLongitude: pRead.longitude, pSignalStrength: pRead.signalStrength, pCarrierName: pRead.carrierName)
        paramRead = self.applyPrecisionCoeficient(paramRead)
        let index = self.searchInReads(paramRead)
        if (index == -1){
            self.reads.append(paramRead)
        } else {
            let firstRead = self.reads[index]
            let newSignalValue = ( Double(firstRead.signalStrength.signalValue) * (1 - Constants.ALPHA) ) + ( Double(paramRead.signalStrength.signalValue) * Constants.ALPHA )
            let newSignalStrength = SignalStrengthValue(pASUValue: Int(newSignalValue))
            reads[index].signalStrength = newSignalStrength
        }
    
    }
    
    private func applyPrecisionCoeficient(pRead:Read)->Read{
        
        let latitudeINT = (Int(pRead.latitude / self.precisionCoeficient))
        let qLatitude = Double(latitudeINT) * self.precisionCoeficient
        pRead.latitude = qLatitude
        
        let longitudeINT = (Int(pRead.longitude / self.precisionCoeficient))
        let qLongitude = Double(longitudeINT) * self.precisionCoeficient
        pRead.longitude = qLongitude
        
        return pRead
    }
    
    private func searchInReads(pRead:Read)->Int{
        var index = 0
        for r:Read in self.reads {
            if (r.latitude == pRead.latitude && r.longitude == pRead.longitude){
                return index
            }
        index = index + 1
        }
        return -1
    }

    
    //Beginning of NSCoding Methods
    required convenience init?(coder decoder: NSCoder) {
        
        
        guard let dID = decoder.decodeObjectForKey("id") as? Int
            else {return nil }
        
        guard let dMinDelta = decoder.decodeObjectForKey("minDelta") as? Double
            else {return nil }
        
        guard let dMaxDelta = decoder.decodeObjectForKey("maxDelta") as? Double
            else {return nil }
        
        guard let dPrecisionCoeficient = decoder.decodeObjectForKey("precisionCoeficient") as? Double
            else {return nil }
        
        guard let dReads = decoder.decodeObjectForKey("reads") as? [Read]
            else {return nil }
        
        self.init(pID: dID, pMinDelta: dMinDelta, pMaxDelta: dMaxDelta, pPrecisionCoeficient: dPrecisionCoeficient, pReads: dReads)
    }
    
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.ID, forKey: "id")
        coder.encodeObject(self.minDelta, forKey: "minDelta")
        coder.encodeObject(self.maxDelta, forKey: "maxDelta")
        coder.encodeObject(self.precisionCoeficient, forKey: "precisionCoeficient")
        coder.encodeObject(self.reads, forKey: "reads")
    }
    //End of NSCoding Methods
    
}