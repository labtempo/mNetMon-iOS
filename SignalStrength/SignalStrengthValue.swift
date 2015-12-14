//
//  SignalStrengthValue.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 07/12/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//
import Foundation

class SignalStrengthValue{
    var signalValue:Int
    var signalQuality:SignalQuality
    
    init(pSignalValue:Int){
        self.signalValue = pSignalValue
        self.signalQuality = SignalQuality.calculateSignalQuality(pSignalValue)
    }

}