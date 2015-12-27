//
//  SignalQuality.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 07/12/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import Foundation


enum SignalQuality {
    
    case verybad
    case bad
    case regular
    case good
    case verygood

    /*
     muito ruim [ 0 ]
     ruim [ 1 - 8 ]
     regular [ 9 - 16 ]
     bom [ 17 - 24 ]
     muito bom [ 25 - 31 ]
    */
    static func calculateSignalQuality(pSignalValue:Int)->SignalQuality{
        if (pSignalValue > 25){
            return self.verygood
        } else if ( pSignalValue <= 24 && pSignalValue >= 17 ) {
            return self.good
        } else if ( pSignalValue <= 16 && pSignalValue >= 9 ) {
            return self.regular
        } else if ( pSignalValue <= 8 && pSignalValue >= 1 ) {
            return self.bad
        } else {
            return self.verybad
        }
    }
    
    static func signalQualityToString(pSignalQuality:SignalQuality)->String{
        if (pSignalQuality == self.verybad){
            return "Very Bad"
        } else if (pSignalQuality == self.bad){
            return "Bad"
        } else if (pSignalQuality == self.regular){
            return "Regular"
        } else if (pSignalQuality == self.good){
            return "Good"
        } else if (pSignalQuality == self.verygood){
            return "VeryGood"
        }
        return ""
    }
    
}