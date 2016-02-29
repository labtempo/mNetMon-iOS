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
    
    
    return ReadsLayers()
    
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