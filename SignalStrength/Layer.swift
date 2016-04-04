//
//  Layer.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 04/04/16.
//  Copyright © 2016 Henrique do Prado Linhares. All rights reserved.
//

import Foundation

class Layer{
    
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
        let ppRead = self.applyPrecisionCoeficient(pRead)
        let index = self.searchInReads(ppRead)
        if (index == -1){
            self.reads.append(ppRead)
        } else {
            let firstRead = self.reads[index]
            let newSignalValue = ( Double(firstRead.signalStrength.signalValue) * (1 - Constants.ALPHA) ) + ( Double(ppRead.signalStrength.signalValue) * Constants.ALPHA )
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
    
    func searchInReads(pRead:Read)->Int{
        var index = 0
        for r:Read in self.reads {
            if (r.latitude == pRead.latitude && r.longitude == pRead.longitude){
                return index
            }
        index = index + 1
        }
        return -1
    }
    
}