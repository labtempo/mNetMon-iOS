//
//  SignalConverter.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 24/12/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import Foundation

class SignalConverter{

    func DBMtoASU(pDBM:Int)->Int{
        return (pDBM + 113) / 2
    }

    func ASUtoDBM(pASU:Int)->Int{
        return (pASU * 2) - 113
    }
}