//
//  ReadsManagement.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 16/02/16.
//  Copyright © 2016 Henrique do Prado Linhares. All rights reserved.
//

import Foundation


class ReadsManagement{

    let alpha = 0.5
    
    
    
    func addReadToReadsLayers(pRead:Read, pReadsLayers:ReadsLayers)->ReadsLayers{
        
        pReadsLayers.readsLayer1 = self.addReadToReads(pRead, pReads: pReadsLayers.readsLayer1)
        
      /*  pReadsLayers.readsLayer2 = self.addReadToReads(pRead, precision: 0.004, pReads: pReadsLayers.readsLayer2)
        
        pReadsLayers.readsLayer3 = self.addReadToReads(pRead, precision: 0.008, pReads: pReadsLayers.readsLayer3)
        
        pReadsLayers.readsLayer4 = self.addReadToReads(pRead, precision: 0.016, pReads: pReadsLayers.readsLayer4)
        
        pReadsLayers.readsLayer5 = self.addReadToReads(pRead, precision: 0.032, pReads: pReadsLayers.readsLayer5)
        
        pReadsLayers.readsLayer6 = self.addReadToReads(pRead, precision: 0.064, pReads: pReadsLayers.readsLayer6)
        
        pReadsLayers.readsLayer7 = self.addReadToReads(pRead, precision: 0.128, pReads: pReadsLayers.readsLayer7)
        
        pReadsLayers.readsLayer8 = self.addReadToReads(pRead, precision: 0.256, pReads: pReadsLayers.readsLayer8)
        
        pReadsLayers.readsLayer9 = self.addReadToReads(pRead, precision: 0.512, pReads: pReadsLayers.readsLayer9)
        
        pReadsLayers.readsLayer10 = self.addReadToReads(pRead, precision: 1.024, pReads: pReadsLayers.readsLayer10)
        
        pReadsLayers.readsLayer11 = self.addReadToReads(pRead, precision: 2.048, pReads: pReadsLayers.readsLayer11)
        
        pReadsLayers.readsLayer12 = self.addReadToReads(pRead, precision: 4.096, pReads: pReadsLayers.readsLayer12)
        
        pReadsLayers.readsLayer13 = self.addReadToReads(pRead, precision: 8.192, pReads: pReadsLayers.readsLayer13)
        
        pReadsLayers.readsLayer14 = self.addReadToReads(pRead, precision: 16.384, pReads: pReadsLayers.readsLayer14)
        
        pReadsLayers.readsLayer15 = self.addReadToReads(pRead, precision: 32.768, pReads: pReadsLayers.readsLayer15)

        pReadsLayers.readsLayer16 = self.addReadToReads(pRead, precision: 65.536, pReads: pReadsLayers.readsLayer16)  */
        
        return pReadsLayers
    }
    
    
    
    
    
    /*
    Function used to add another read to the reads.
    */
    func addReadToReads(pRead:Read , pReads:[Read])->[Read]{
        
        var reads = pReads
        
        let searchResult = self.searchInReads(pRead, pReads: reads)
        if (searchResult > -1){
            let firstRead = reads[searchResult]
            let newSignalValue = ( Double(firstRead.signalStrength.signalValue) * (1 - alpha) ) + ( Double(pRead.signalStrength.signalValue) * alpha )
            let newSignalStrength = SignalStrengthValue(pASUValue: Int(newSignalValue))
            reads[searchResult].signalStrength = newSignalStrength
            
        } else {
            reads.append(pRead)
        }
    
        return reads
    }


    func addReadToReads(pRead:Read , precision:Double, pReads:[Read])->[Read]{
        
        var reads = pReads
        let read = pRead
        
        
        let latitudeINT = (Int(read.latitude / precision))
        let qLatitude = Double(latitudeINT) * precision
        read.latitude = qLatitude
        
        let longitudeINT = (Int(read.longitude / precision))
        let qLongitude = Double(longitudeINT) * precision
        read.longitude = qLongitude
        
        
        let searchResult = self.searchInReads(read, pReads: reads)
        if (searchResult > -1){
            let firstRead = reads[searchResult]
            let newSignalValue = ( Double(firstRead.signalStrength.signalValue) * (1 - alpha) ) + ( Double(pRead.signalStrength.signalValue) * alpha )
            let newSignalStrength = SignalStrengthValue(pASUValue: Int(newSignalValue))
            reads[searchResult].signalStrength = newSignalStrength
            
        } else {
            reads.append(read)
        }
        
        return reads
    }
    
    
    
    
    /*
    
    If the app have already made another read in the same location as the parameter pRead location, return the index of the read
    
    else return -1
    */
    private func searchInReads(pRead:Read , pReads:[Read])->Int{
        var index = 0
        for r:Read in pReads{
            if ( (r.latitude == pRead.latitude) && (r.longitude == pRead.longitude) ){
                return index
            }
            index = index + 1
        }
        return -1
    }


}