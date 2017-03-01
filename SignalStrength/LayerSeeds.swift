//
//  LayerFactory.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 11/09/16.
//  Copyright © 2016 Henrique do Prado Linhares. All rights reserved.
//

import Foundation
import RealmSwift


class LayerSeeds{
    
    func createEmptyLayers(){
        
        let realm = try! Realm()
        
        
        let layer01 = Layer()
        layer01.id = 1
        layer01.minCameraAltitude = 0
        layer01.maxCameraAltitude = 2906.4
        layer01.precisionCoeficient = 0.002
        try! realm.write{ realm.add(layer01) }
        
        
        let layer02 = Layer()
        layer02.id = 2
        layer02.minCameraAltitude = 2906.5
        layer02.maxCameraAltitude = 5812.4
        layer02.precisionCoeficient = 0.004
        try! realm.write{ realm.add(layer02) }
        
        let layer03 = Layer()
        layer03.id = 3
        layer03.minCameraAltitude = 5812.5
        layer03.maxCameraAltitude = 11624.4
        layer03.precisionCoeficient = 0.008
        try! realm.write{ realm.add(layer03) }
        
        let layer04 = Layer()
        layer04.id = 4
        layer04.minCameraAltitude = 11624.5
        layer04.maxCameraAltitude = 23249.4
        layer04.precisionCoeficient = 0.016
        try! realm.write{ realm.add(layer04) }
        
        let layer05 = Layer()
        layer05.id = 5
        layer05.minCameraAltitude = 23249.5
        layer05.maxCameraAltitude = 46498.4
        layer05.precisionCoeficient = 0.032
        try! realm.write{ realm.add(layer05) }
        
        let layer06 = Layer()
        layer06.id = 6
        layer06.minCameraAltitude = 46498.5
        layer06.maxCameraAltitude = 92996.4
        layer06.precisionCoeficient = 0.064
        try! realm.write{ realm.add(layer06) }
        
    
        let layer07 = Layer()
        layer07.id = 7
        layer07.minCameraAltitude = 92996.5
        layer07.maxCameraAltitude = 185993.4
        layer07.precisionCoeficient = 0.128
        try! realm.write{ realm.add(layer07) }
        
        
        let layer08 = Layer()
        layer08.id = 8
        layer08.minCameraAltitude = 185993.5
        layer08.maxCameraAltitude = 371986.4
        layer08.precisionCoeficient = 0.256
        try! realm.write{ realm.add(layer08) }

        
        let layer09 = Layer()
        layer09.id = 9
        layer09.minCameraAltitude = 371986.5
        layer09.maxCameraAltitude = 743973.4
        layer09.precisionCoeficient = 0.512
        try! realm.write{ realm.add(layer09) }
        
        
        let layer10 = Layer()
        layer10.id = 10
        layer10.minCameraAltitude = 743973.5
        layer10.maxCameraAltitude = 1487946.4
        layer10.precisionCoeficient = 1.024
        try! realm.write{ realm.add(layer10) }
        
        
        let layer11 = Layer()
        layer11.id = 11
        layer11.minCameraAltitude = 1487946.5
        layer11.maxCameraAltitude = 2975892.4
        layer11.precisionCoeficient = 2.048
        try! realm.write{ realm.add(layer11) }
        

        let layer12 = Layer()
        layer12.id = 12
        layer12.minCameraAltitude = 2975892.5
        layer12.maxCameraAltitude = 5951785.4
        layer12.precisionCoeficient = 4.096
        try! realm.write{ realm.add(layer12) }

        let layer13 = Layer()
        layer13.id = 13
        layer13.minCameraAltitude = 5951785.5
        layer13.maxCameraAltitude = 11903571.4
        layer13.precisionCoeficient = 8.192
        try! realm.write{ realm.add(layer13) }

        let layer14 = Layer()
        layer14.id = 14
        layer14.minCameraAltitude = 11903571.5
        layer14.maxCameraAltitude = 23807142.4
        layer14.precisionCoeficient = 16.384
        try! realm.write{ realm.add(layer14) }
        
        let layer15 = Layer()
        layer15.id = 15
        layer15.minCameraAltitude = 23807142.5
        layer15.maxCameraAltitude = 47614284.4
        layer15.precisionCoeficient = 32.768
        try! realm.write{ realm.add(layer15) }
                
        let layer16 = Layer()
        layer16.id = 16
        layer16.minCameraAltitude = 47614284.5
        layer16.maxCameraAltitude = Double.infinity
        layer16.precisionCoeficient = 65.536
        try! realm.write{ realm.add(layer16) }
        
    }
    
    
}