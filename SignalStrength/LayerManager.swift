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

    /*
    static func getReadsByLayer(layerID:Int)->[Read]{
        
        var precision:Double = 0
        
        if (layerID == 1){
            return AppData.sharedInstance.getReads()
        } else {
        
            if (layerID == 2){
                precision = 0.004
            }
        
        
        }
        
        var firstLayerReads = AppData.sharedInstance.getReads()
        var currentLayerReads = [Read]()
        
        for r:Read in firstLayerReads {
            
            let pLatitude = r.latitude
            let latitudeINT = (Int(pLatitude / precision))
            let qLatitude = Double(latitudeINT) * precision
            r.latitude = qLatitude
            
            
            let pLongitude = r.longitude
            let longitudeINT = (Int(pLongitude / precision))
            let qLongitude = Double(longitudeINT) * precision
            r.longitude = qLongitude
            
            currentLayerReads = ReadsManagement().addReadToReads(r, pReads: currentLayerReads)
        }
        
        return currentLayerReads
    }
  */
}