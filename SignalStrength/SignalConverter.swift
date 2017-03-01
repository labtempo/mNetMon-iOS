//
//  SignalConverter.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 24/12/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import Foundation

class SignalConverter{

    static func DBMtoASU(pDBM:Double)->Double{
        return (pDBM + 113) / 2
    }

    static func ASUtoDBM(pASU:Double)->Double{
        return (pASU * 2) - 113
    }
}