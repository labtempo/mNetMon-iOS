//
//  SignalStrengthValue.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 07/12/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//
import Foundation

class SignalStrengthValue:NSObject, NSCoding{
    var signalValue:Int
    var signalQuality:SignalQuality
    
    init(pSignalValue:Int){
        self.signalValue = pSignalValue
        self.signalQuality = SignalQuality.calculateSignalQuality(pSignalValue)
    }
    
    init(pDBMValue:Int){
        self.signalValue = SignalConverter().DBMtoASU(pDBMValue)
        self.signalQuality = SignalQuality.calculateSignalQuality(self.signalValue)
    }
    
    //NSCoding Methods
    required convenience init?(coder decoder: NSCoder) {
        
        guard let dSignalValue = decoder.decodeObjectForKey("signalValue") as? Int
            else {return nil }
        
        self.init(pSignalValue: dSignalValue)
    }
    
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.signalValue, forKey: "signalValue")
    }


}