//
//  SignalQuality.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 07/12/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import Foundation


enum SignalQuality {
    
    case verybad    //  1
    case bad        //  2
    case regular    //  3
    case good       //  4
    case verygood    // 5
    
    
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
    
}