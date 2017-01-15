//
//  MapSquare.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 15/01/17.
//  Copyright © 2017 Henrique do Prado Linhares. All rights reserved.
//

import Foundation
import MapKit

class MapSquare: MKPolygon{
    var color:UIColor
    
    init(pColor:UIColor){
        self.color = pColor
        super.init()
    }

}