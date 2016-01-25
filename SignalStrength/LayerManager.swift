//
//  LayerManager.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 13/01/16.
//  Copyright © 2016 Henrique do Prado Linhares. All rights reserved.
//

import Foundation
import MapKit

class LayerManager {
    
    //Default value : 2200.0
    static let deltaCoeficientMultiplier = 2200.0


    static func getReadsByDeltaCoeficient(pDeltaCoeficient:Double)->[Read]{
        
        var firstLayerReads = AppData.sharedInstance.getReads()
        var currentLayerReads = [Read]()
        
        while (!firstLayerReads.isEmpty){
            let r = firstLayerReads.removeFirst()
            
            var neightbors = self.searchForRead(r.latitude, pLongitude: r.longitude, pReads: firstLayerReads, deltaCoeficient: pDeltaCoeficient)
            if (neightbors.isEmpty){
                currentLayerReads.append(r)
                
            } else {
                neightbors.append(r)
                
                for n:Read in neightbors {
                    let index = firstLayerReads.indexOf(n)
                    if ((index) != nil){
                        firstLayerReads.removeAtIndex(index!)
                    }
                
                }
                
                currentLayerReads.append(mergeNeightbors(neightbors))
            }
        
        }
        
        return currentLayerReads
    }

    
    
    private static func searchForRead(pLatitude:Double , pLongitude:Double , pReads:[Read], deltaCoeficient:Double)->[Read]{
        let searchedLocation = CLLocation(latitude: pLatitude, longitude: pLongitude)
        var neightbors = [Read]()
        
        for r:Read in pReads{
            
            let rLocation = CLLocation(latitude: r.latitude, longitude: r.longitude)
            let dist = rLocation.distanceFromLocation(searchedLocation)
            if (dist < (self.deltaCoeficientMultiplier * deltaCoeficient)){
                neightbors.append(r)
            }
        }
        return neightbors
    }
    
    private static func mergeNeightbors(pNeightbors:[Read])->Read{
        if (pNeightbors.count == 1){
            return pNeightbors.first!
        } else {
            var latitudeSum = 0.0
            var longitudeSum = 0.0
            var signalStrenghtSum = 0
            for r:Read in pNeightbors{
                latitudeSum = latitudeSum + r.latitude
                longitudeSum = longitudeSum + r.longitude
                signalStrenghtSum = signalStrenghtSum + r.signalStrength.signalValue
            }
            
            let latitude = latitudeSum / Double(pNeightbors.count)
            let longitude = longitudeSum / Double(pNeightbors.count)
            let signalStrenght = signalStrenghtSum / pNeightbors.count
            
            return Read(pID: (pNeightbors.first?.ID)!, pLatitude: latitude, pLongitude: longitude, pSignalStrength: SignalStrengthValue(pASUValue: signalStrenght), pCarrierName: "nil")
        }

    }

}