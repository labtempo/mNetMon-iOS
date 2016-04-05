//
//  LayerTest.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 04/04/16.
//  Copyright © 2016 Henrique do Prado Linhares. All rights reserved.
//

import XCTest
@testable import SignalStrength

class LayerTest: XCTestCase {
    
    
    
    
    
    func testApplyPrecisionCoeficient1(){
        let layer1 = Layer(pID: 1, pMinDelta: 0, pMaxDelta: 0, pPrecisionCoeficient: 0.002)
        let r0 = Read(pLatitude: -22.90454212, pLongitude: -43.1076049, pSignalStrength: SignalStrengthValue(pASUValue: 0), pCarrierName: "Claro")
        layer1.addRead(r0)
        
        print(layer1.reads[0].latitude)
        print(layer1.reads[0].longitude)
        
        XCTAssertEqual(-22.904, layer1.reads[0].latitude)
        XCTAssertEqual(-43.106, layer1.reads[0].longitude)
    }
    

    
    func testBusca1() {
        let myLayer = Layer(pID: 1, pMinDelta: 0, pMaxDelta: 0, pPrecisionCoeficient: 0.002)
        let r0 = Read(pLatitude: -22.90454212, pLongitude: -43.1076049, pSignalStrength: SignalStrengthValue(pASUValue: 0), pCarrierName: "Claro")
        let index = myLayer.searchInReads(r0)
        XCTAssertEqual(index, -1)
    }
    
    func testBusca2(){
    
    }
    
    
}
