//
//  SignalConverterTest.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 05/04/16.
//  Copyright © 2016 Henrique do Prado Linhares. All rights reserved.
//

import XCTest
@testable import SignalStrength

class SignalConverterTest: XCTestCase {
    
    
    func testDBMtoASU1() {
        let result = SignalConverter().DBMtoASU(-111)
        XCTAssertEqual(result, 1)
    }

    func testDBMtoASU2() {
        let result = SignalConverter().DBMtoASU(-79)
        XCTAssertEqual(result, 17)
    }

    func testDBMtoASU3() {
        let result = SignalConverter().DBMtoASU(-57)
        XCTAssertEqual(result, 28)
    }

    
    func testASUtoDBM1(){
        let result = SignalConverter().ASUtoDBM(0)
        XCTAssertEqual(result, -113)
    }
    
    func testASUtoDBM2(){
        let result = SignalConverter().ASUtoDBM(15)
        XCTAssertEqual(result, -83)
    }
    
    func testASUtoDBM3(){
        let result = SignalConverter().ASUtoDBM(31)
        XCTAssertEqual(result, -51)
    }
    
}
