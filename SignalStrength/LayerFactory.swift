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
        
        var layers = [Layer]()
        
        let layer01 = Layer()
        layer01.id = 1
        layer01.minDelta = 0
        layer01.maxDelta = 0.040
        layer01.precisionCoeficient = 0.002
        layers.append(layer01)
        
        let layer02 = Layer()
        layer02.id = 2
        layer02.minDelta = 0.041
        layer02.maxDelta = 0.1
        layer02.precisionCoeficient = 0.004
        layers.append(layer02)
        
        
        
        /*
         
        //cria o layer 03
        let layer03 = Layer(pID: 3, pMinDelta: 0.11, pMaxDelta: 0.231, pPrecisionCoeficient: 0.008)
        self.layers.append(layer03)
        
        //cria o layer 04
        let layer04 = Layer(pID: 4, pMinDelta: 0.232, pMaxDelta: 0.465, pPrecisionCoeficient: 0.016)
        self.layers.append(layer04)
        
        //cria o layer 05
        let layer05 = Layer(pID: 5, pMinDelta: 0.466, pMaxDelta: 1.281, pPrecisionCoeficient: 0.032)
        self.layers.append(layer05)
        
        //cria o layer 06
        let layer06 = Layer(pID: 6, pMinDelta: 1.282, pMaxDelta: 2.100, pPrecisionCoeficient: 0.064)
        self.layers.append(layer06)
        
        //cria o layer 07
        let layer07 = Layer(pID: 7, pMinDelta: 2.101, pMaxDelta: 4.455, pPrecisionCoeficient: 0.128)
        self.layers.append(layer07)
        
        //cria o layer 08
        let layer08 = Layer(pID: 8, pMinDelta: 4.456, pMaxDelta: 10.000, pPrecisionCoeficient: 0.256)
        self.layers.append(layer08)
        
        //cria o layer 09
        let layer09 = Layer(pID: 9, pMinDelta: 10.001, pMaxDelta: 25.000, pPrecisionCoeficient: 0.512)
        self.layers.append(layer09)
        
        //cria o layer 10
        let layer10 = Layer(pID: 10, pMinDelta: 25.001, pMaxDelta: 35.000, pPrecisionCoeficient: 1.024)
        self.layers.append(layer10)
        
        //cria o layer 11
        let layer11 = Layer(pID: 11, pMinDelta: 35.001, pMaxDelta: 40.000, pPrecisionCoeficient: 2.048)
        self.layers.append(layer11)
        
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
        
        let realm = RealmInterface.sharedInstance.getRealmInstance()
        
        for lay:Layer in layers{
            try! realm.write{
                realm.add(lay)
            }
        }
        
    }
    
    
}