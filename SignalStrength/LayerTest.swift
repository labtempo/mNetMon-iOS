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
    
    
    func testLayer1(){
        let layer1 = Layer(pID: 1, pMinDelta: 0, pMaxDelta: 0, pPrecisionCoeficient: 0.002)
        let r0 = Read(pLatitude: -22.90454212, pLongitude: -43.1076049, pSignalStrength: SignalStrengthValue(pASUValue: 0), pCarrierName: "Claro")
        layer1.addRead(r0)
        
        XCTAssertEqual(-22.904, layer1.reads[0].latitude)
        XCTAssertEqual(-43.106, layer1.reads[0].longitude)
    }
    
    func testLayer2(){
        let layer1 = Layer(pID: 2, pMinDelta: 0, pMaxDelta: 0, pPrecisionCoeficient: 0.004)
        let r0 = Read(pLatitude: -22.90454212, pLongitude: -43.1076049, pSignalStrength: SignalStrengthValue(pASUValue: 0), pCarrierName: "Claro")
        layer1.addRead(r0)
        
        XCTAssertEqual(-22.904, layer1.reads[0].latitude)
        XCTAssertEqual(-43.104, layer1.reads[0].longitude)
    }
    
    func testLayer3(){
        let layer1 = Layer(pID: 3, pMinDelta: 0, pMaxDelta: 0, pPrecisionCoeficient: 0.008)
        let r0 = Read(pLatitude: -22.90454212, pLongitude: -43.1076049, pSignalStrength: SignalStrengthValue(pASUValue: 0), pCarrierName: "Claro")
        layer1.addRead(r0)
        
        XCTAssertEqual(-22.904, layer1.reads[0].latitude)
        XCTAssertEqual(-43.104, layer1.reads[0].longitude)
    }
    
    func testLayer4(){
        let layer1 = Layer(pID: 4, pMinDelta: 0, pMaxDelta: 0, pPrecisionCoeficient: 0.016)
        let r0 = Read(pLatitude: -22.90454212, pLongitude: -43.1076049, pSignalStrength: SignalStrengthValue(pASUValue: 0), pCarrierName: "Claro")
        layer1.addRead(r0)
        
        XCTAssertEqual(-22.896, layer1.reads[0].latitude)
        XCTAssertEqual(-43.104, layer1.reads[0].longitude)
    }
    
    func testLayer5(){
        let layer1 = Layer(pID: 5, pMinDelta: 0, pMaxDelta: 0, pPrecisionCoeficient: 0.032)
        let r0 = Read(pLatitude: -22.90454212, pLongitude: -43.1076049, pSignalStrength: SignalStrengthValue(pASUValue: 0), pCarrierName: "Claro")
        layer1.addRead(r0)
        
        XCTAssertEqual(-22.88, layer1.reads[0].latitude)
        XCTAssertEqual(-43.104, layer1.reads[0].longitude)
    }
    
    func testLayer6(){
        let layer1 = Layer(pID: 6, pMinDelta: 0, pMaxDelta: 0, pPrecisionCoeficient: 0.064)
        let r0 = Read(pLatitude: -22.90454212, pLongitude: -43.1076049, pSignalStrength: SignalStrengthValue(pASUValue: 0), pCarrierName: "Claro")
        layer1.addRead(r0)
        
        XCTAssertEqual(-22.848, layer1.reads[0].latitude)
        XCTAssertEqual(-43.072, layer1.reads[0].longitude)
    }
    
    
    func testLayer7(){
        let layer1 = Layer(pID: 7, pMinDelta: 0, pMaxDelta: 0, pPrecisionCoeficient: 0.128)
        let r0 = Read(pLatitude: -22.90454212, pLongitude: -43.1076049, pSignalStrength: SignalStrengthValue(pASUValue: 0), pCarrierName: "Claro")
        layer1.addRead(r0)
        
        XCTAssertEqual(-22.784, layer1.reads[0].latitude)
        XCTAssertEqual(-43.008, layer1.reads[0].longitude)
    }
    
    
    func testLayer8(){
        let layer1 = Layer(pID: 8, pMinDelta: 0, pMaxDelta: 0, pPrecisionCoeficient: 0.256)
        let r0 = Read(pLatitude: -22.90454212, pLongitude: -43.1076049, pSignalStrength: SignalStrengthValue(pASUValue: 0), pCarrierName: "Claro")
        layer1.addRead(r0)
        
        XCTAssertEqual(-22.784, layer1.reads[0].latitude)
        XCTAssertEqual(-43.008, layer1.reads[0].longitude)
    }
    

    func testLayer9(){
        let layer1 = Layer(pID: 9, pMinDelta: 0, pMaxDelta: 0, pPrecisionCoeficient: 0.512)
        let r0 = Read(pLatitude: -22.90454212, pLongitude: -43.1076049, pSignalStrength: SignalStrengthValue(pASUValue: 0), pCarrierName: "Claro")
        layer1.addRead(r0)
        
        XCTAssertEqual(-22.528, layer1.reads[0].latitude)
        XCTAssertEqual(-43.008, layer1.reads[0].longitude)
    }
    

    func testLayer10(){
        let layer1 = Layer(pID: 10, pMinDelta: 0, pMaxDelta: 0, pPrecisionCoeficient: 1.024)
        let r0 = Read(pLatitude: -22.90454212, pLongitude: -43.1076049, pSignalStrength: SignalStrengthValue(pASUValue: 0), pCarrierName: "Claro")
        layer1.addRead(r0)
        
        XCTAssertEqual(-22.528, layer1.reads[0].latitude)
        XCTAssertEqual(-43.008, layer1.reads[0].longitude)
    }
    
    
    func testLayer11(){
        let layer1 = Layer(pID: 11, pMinDelta: 0, pMaxDelta: 0, pPrecisionCoeficient: 2.048)
        let r0 = Read(pLatitude: -22.90454212, pLongitude: -43.1076049, pSignalStrength: SignalStrengthValue(pASUValue: 0), pCarrierName: "Claro")
        layer1.addRead(r0)
        
        XCTAssertEqual(-22.528, layer1.reads[0].latitude)
        XCTAssertEqual(-43.008, layer1.reads[0].longitude)
    }
    
    
    func testLayer12(){
        let layer1 = Layer(pID: 12, pMinDelta: 0, pMaxDelta: 0, pPrecisionCoeficient: 4.096)
        let r0 = Read(pLatitude: -22.90454212, pLongitude: -43.1076049, pSignalStrength: SignalStrengthValue(pASUValue: 0), pCarrierName: "Claro")
        layer1.addRead(r0)
        
        XCTAssertEqual(-20.48, layer1.reads[0].latitude)
        XCTAssertEqual(-40.96, layer1.reads[0].longitude)
    }
    
    
    func testLayer13(){
        let layer1 = Layer(pID: 13, pMinDelta: 0, pMaxDelta: 0, pPrecisionCoeficient: 8.192)
        let r0 = Read(pLatitude: -22.90454212, pLongitude: -43.1076049, pSignalStrength: SignalStrengthValue(pASUValue: 0), pCarrierName: "Claro")
        layer1.addRead(r0)
        
        XCTAssertEqual(-16.384, layer1.reads[0].latitude)
        XCTAssertEqual(-40.96, layer1.reads[0].longitude)
    }
    
    
    func testLayer14(){
        let layer1 = Layer(pID: 14, pMinDelta: 0, pMaxDelta: 0, pPrecisionCoeficient: 16.384)
        let r0 = Read(pLatitude: -22.90454212, pLongitude: -43.1076049, pSignalStrength: SignalStrengthValue(pASUValue: 0), pCarrierName: "Claro")
        layer1.addRead(r0)
        
        XCTAssertEqual(-16.384, layer1.reads[0].latitude)
        XCTAssertEqual(-32.768, layer1.reads[0].longitude)
    }
    

    func testLayer15(){
        let layer1 = Layer(pID: 15, pMinDelta: 0, pMaxDelta: 0, pPrecisionCoeficient: 32.768)
        let r0 = Read(pLatitude: -22.90454212, pLongitude: -43.1076049, pSignalStrength: SignalStrengthValue(pASUValue: 0), pCarrierName: "Claro")
        layer1.addRead(r0)
        
        XCTAssertEqual(0, layer1.reads[0].latitude)
        XCTAssertEqual(-32.768, layer1.reads[0].longitude)
    }
    
    
    func testLayer16(){
        let layer1 = Layer(pID: 16, pMinDelta: 0, pMaxDelta: 0, pPrecisionCoeficient: 65.536)
        let r0 = Read(pLatitude: -22.90454212, pLongitude: -43.1076049, pSignalStrength: SignalStrengthValue(pASUValue: 0), pCarrierName: "Claro")
        layer1.addRead(r0)
        
        XCTAssertEqual(0, layer1.reads[0].latitude)
        XCTAssertEqual(0, layer1.reads[0].longitude)
    }
    
    
    
    
}
