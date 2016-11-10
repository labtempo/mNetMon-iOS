//
//  Layer.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 04/04/16.
//  Copyright © 2016 Henrique do Prado Linhares. All rights reserved.
//

import Foundation
import RealmSwift

class Layer: Object{
    
    dynamic var id:Int = 0
    dynamic var minDelta:Double = 0.0
    dynamic var maxDelta:Double = 0.0
    dynamic var precisionCoeficient:Double = 0.0
    let reads = List<Read>()
    
    func canBeUsedWithCurrentDelta(pDelta:Double)->Bool{
        if (pDelta >= self.minDelta && pDelta < self.maxDelta){
            return true
        }
        
        return false
    }
    
    func addRead(pRead:Read){
        var newRead = Read()
        newRead.latitude = pRead.latitude
        newRead.longitude = pRead.longitude
        newRead.signalStrength = pRead.signalStrength
        newRead.carrierName = pRead.carrierName
        
        newRead = applyPrecisionCoeficient(newRead)
        let index = self.searchInReads(newRead)
        if (index == -1){
            let realm = RealmInterface.sharedInstance.getRealmInstance()
            try! realm.write{
                print(self.reads)
                self.reads.append(newRead)
                print(self.reads)
            }
            
        } else {
            print("##### ATUALIZOU #######") /* TEM QUE TERMINAR DE DEBUGAR ESSA PARADA AQUI */
            let firstRead = self.reads[index]
            self.reads.removeAtIndex(index)
            let newSignalStrengthValue = ( Double(firstRead.signalStrength) * (1 - Constants.ALPHA) ) + ( Double(newRead.signalStrength) * Constants.ALPHA )
            firstRead.signalStrength = newSignalStrengthValue
            self.reads.insert(firstRead, atIndex: index)
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
    
}