//
//  SignalStrengthValue.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 07/12/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//
import Foundation

class SignalStrengthValue:NSObject{
    
    var signalASU:Double
    var signalQuality:SignalQuality
    
    init(pASUValue:Double){
        self.signalASU = pASUValue
        self.signalQuality = SignalQuality.calculateSignalQuality(pASUValue)
    }
    
    init(pDBMValue:Double){
        self.signalASU = SignalConverter().DBMtoASU(pDBMValue)
        self.signalQuality = SignalQuality.calculateSignalQuality(self.signalASU)
    }
    
}