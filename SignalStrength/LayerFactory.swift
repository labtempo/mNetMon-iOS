//
//  LayerFactory.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 11/09/16.
//  Copyright © 2016 Henrique do Prado Linhares. All rights reserved.
//

import Foundation
import RealmSwift


class LayerFactory{
    
    func createEmptyLayers(){
        
        let realm = RealmInterface.sharedInstance.getRealmInstance()
        
        
        let layer01 = Layer()
        layer01.id = 1
        layer01.minDelta = 0
        layer01.maxDelta = 0.040
        layer01.precisionCoeficient = 0.002
        try! realm.write{ realm.add(layer01) }
        
        
        let layer02 = Layer()
        layer02.id = 2
        layer02.minDelta = 0.041
        layer02.maxDelta = 0.1
        layer02.precisionCoeficient = 0.004
        try! realm.write{ realm.add(layer02) }
        
        let layer03 = Layer()
        layer03.id = 3
        layer03.minDelta = 0.11
        layer03.maxDelta = 0.231
        layer03.precisionCoeficient = 0.008
        try! realm.write{ realm.add(layer03) }
        
        let layer04 = Layer()
        layer04.id = 4
        layer04.minDelta = 0.232
        layer04.maxDelta = 0.465
        layer04.precisionCoeficient = 0.016
        try! realm.write{ realm.add(layer04) }
        
        let layer05 = Layer()
        layer05.id = 5
        layer05.minDelta = 0.466
        layer05.maxDelta = 1.281
        layer05.precisionCoeficient = 0.032
        try! realm.write{ realm.add(layer05) }
        
        let layer06 = Layer()
        layer06.id = 6
        layer06.minDelta = 1.282
        layer06.maxDelta = 2.100
        layer06.precisionCoeficient = 0.064
        try! realm.write{ realm.add(layer06) }
        
    
        let layer07 = Layer()
        layer07.id = 7
        layer07.minDelta = 2.101
        layer07.maxDelta = 4.455
        layer07.precisionCoeficient = 0.128
        try! realm.write{ realm.add(layer07) }
        
        
        let layer08 = Layer()
        layer08.id = 8
        layer08.minDelta = 4.456
        layer08.maxDelta = 10.000
        layer08.precisionCoeficient = 0.256
        try! realm.write{ realm.add(layer08) }

        
        let layer09 = Layer()
        layer09.id = 9
        layer09.minDelta = 10.001
        layer09.maxDelta = 25.000
        layer09.precisionCoeficient = 0.512
        try! realm.write{ realm.add(layer09) }
        
        
        let layer10 = Layer()
        layer10.id = 10
        layer10.minDelta = 25.001
        layer10.maxDelta = 35.000
        layer10.precisionCoeficient = 1.024
        try! realm.write{ realm.add(layer10) }
        
        
        let layer11 = Layer()
        layer11.id = 11
        layer11.minDelta = 35.001
        layer11.maxDelta = 40.000
        layer11.precisionCoeficient = 2.048
        try! realm.write{ realm.add(layer11) }
        

        let layer12 = Layer()
        layer12.id = 12
        layer12.minDelta = 40.001
        layer12.maxDelta = 999999999999
        layer12.precisionCoeficient = 4.096
        try! realm.write{ realm.add(layer12) }
        
        
        /*
        
        
        //cria o layer 12
        let layer12 = Layer(pID: 12, pMinDelta: 40.001, pMaxDelta: 999999999999, pPrecisionCoeficient: 4.096)
        self.layers.append(layer12)
        
        
         //cria o layer 13
         let layer13 = Layer(pID: 13, pMinDelta: 999999999999, pMaxDelta: 999999999999, pPrecisionCoeficient: 8.192)
         self.layers.append(layer13)
         
         //cria o layer 14
         let layer14 = Layer(pID: 14, pMinDelta: 999999999999, pMaxDelta: 999999999999, pPrecisionCoeficient: 16.384)
         self.layers.append(layer14)
         
         //cria o layer 15
         let layer15 = Layer(pID: 15, pMinDelta: 999999999999, pMaxDelta: 999999999999, pPrecisionCoeficient: 32.768)
         self.layers.append(layer15)
         
         //cria o layer 16
         let layer16 = Layer(pID: 16, pMinDelta: 999999999999, pMaxDelta: 999999999999, pPrecisionCoeficient: 65.536)
         self.layers.append(layer16)
         
         */
        
        
    }
    
    
}