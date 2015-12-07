//
//  SignalQuality.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 07/12/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import Foundation


enum SignalQuality{
    case bad
    case regular
    case medium
    case good
    
    
    static func calculateSignalQuality(pSignalValue:Int)->SignalQuality{
        if (pSignalValue >= -80){
            return SignalQuality.good
        } else if (pSignalValue < -80 && pSignalValue >= -95){
            return SignalQuality.medium
        } else if (pSignalValue < -95 && pSignalValue > -110){
            return SignalQuality.regular
        }
        return SignalQuality.bad
    }
    
}