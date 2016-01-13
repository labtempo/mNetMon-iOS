//
//  LayerManager.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 13/01/16.
//  Copyright © 2016 Henrique do Prado Linhares. All rights reserved.
//

import Foundation

class LayerManager {

    static func getLayer1Reads()->[Read]{
        return AppData.sharedInstance.getReads()
    }


    static func getLayer2Reads()->[Read]{
        let firstLayerReads = AppData.sharedInstance.getReads()
        var currentLayerReads = [Read]()
        
        for r:Read in firstLayerReads {
            let neightbors = self.searchForNeighbors(0.002)
            if (neightbors.isEmpty){
                
            }
        
        }
        
        
        
        return currentLayerReads
    }

    
    private static func searchForNeighbors(precision:Double)->[Read]{
    
    }
    
    private static func mergeNeightbors(pNeightbors:[Read])->[Read]{
    
    }

}