//
//  ReadsTests.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 30/12/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import Foundation

class ReadsTests{
    
    func getReads()->[Read]{
        
        var reads = [Read]()
        
        // Campo de são bento
        // sinal muito ruim
        let r0 = Read(pLatitude: -22.90454212, pLongitude: -43.1076049, pSignalStrength: SignalStrengthValue(pASUValue: 0), pCarrierName: "Claro")
        
        reads.append(r0)
        
        
        // Praia de icarai
        // sinal ruim
        let r1 = Read(pLatitude: -22.9058664, pLongitude: -43.1139779, pSignalStrength: SignalStrengthValue(pASUValue: 4), pCarrierName: "Claro")
        
        reads.append(r1)
        
        // Campus Praia Vermelha
        // Sinal Regular
        let r2 = Read(pLatitude: -22.90448283, pLongitude: -43.13301086, pSignalStrength: SignalStrengthValue(pASUValue: 12), pCarrierName: "Claro")
        
        reads.append(r2)
        
        
        // Santa Rosa
        // Sinal Bom
        let r3 = Read(pLatitude: -22.897920412, pLongitude: -43.09816360, pSignalStrength: SignalStrengthValue(pASUValue: 20), pCarrierName: "Claro")
        
        reads.append(r3)
        
        
        // Ponta Da Areia
        // Sinal Muito Bom
        let r4 = Read(pLatitude: -22.88091990, pLongitude: -43.12657356, pSignalStrength: SignalStrengthValue(pASUValue: 28), pCarrierName: "Claro")
        
        reads.append(r4)
        
        
        return reads
    }
    
}