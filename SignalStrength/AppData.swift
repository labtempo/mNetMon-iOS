//
//  AppData.swift
//  Location
//
//  Created by Henrique do Prado Linhares on 18/11/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import Foundation

/*
Singleton responsable for the management of the reads during the app execution
*/
class AppData{
    
    static let sharedInstance = AppData()
    var layers = [Layer]()
    var locationReader = LocationReader()
    
    
    init(){
        
        //cria o layer 01
        let layer01 = Layer(pID: 1, pMinDelta: 0, pMaxDelta: 0.04, pPrecisionCoeficient: 0.002)
        self.layers.append(layer01)
        
        //cria o layer 02
        let layer02 = Layer(pID: 2, pMinDelta: 0.05, pMaxDelta: 999999999999, pPrecisionCoeficient: 0.004)
        self.layers.append(layer02)
        
        //cria o layer 03
        let layer03 = Layer(pID: 3, pMinDelta: 999999999999, pMaxDelta: 999999999999, pPrecisionCoeficient: 0.008)
        self.layers.append(layer03)
        
        //cria o layer 04
        let layer04 = Layer(pID: 4, pMinDelta: 999999999999, pMaxDelta: 999999999999, pPrecisionCoeficient: 0.016)
        self.layers.append(layer04)
        
        //cria o layer 05
        let layer05 = Layer(pID: 5, pMinDelta: 999999999999, pMaxDelta: 999999999999, pPrecisionCoeficient: 0.032)
        self.layers.append(layer05)
        
        //cria o layer 06
        let layer06 = Layer(pID: 6, pMinDelta: 999999999999, pMaxDelta: 999999999999, pPrecisionCoeficient: 0.064)
        self.layers.append(layer06)
        
        //cria o layer 07
        let layer07 = Layer(pID: 7, pMinDelta: 999999999999, pMaxDelta: 999999999999, pPrecisionCoeficient: 0.128)
        self.layers.append(layer07)
        
        //cria o layer 08
        let layer08 = Layer(pID: 8, pMinDelta: 999999999999, pMaxDelta: 999999999999, pPrecisionCoeficient: 0.256)
        self.layers.append(layer08)
        
        //cria o layer 09
        let layer09 = Layer(pID: 9, pMinDelta: 999999999999, pMaxDelta: 999999999999, pPrecisionCoeficient: 0.512)
        self.layers.append(layer09)
        
        //cria o layer 10
        let layer10 = Layer(pID: 10, pMinDelta: 999999999999, pMaxDelta: 999999999999, pPrecisionCoeficient: 1.024)
        self.layers.append(layer10)
        
        //cria o layer 11
        let layer11 = Layer(pID: 11, pMinDelta: 999999999999, pMaxDelta: 999999999999, pPrecisionCoeficient: 2.048)
        self.layers.append(layer11)
        
        //cria o layer 12
        let layer12 = Layer(pID: 12, pMinDelta: 999999999999, pMaxDelta: 999999999999, pPrecisionCoeficient: 4.096)
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
        
    }
    
    
    func addRead(pRead:Read){
        for l:Layer in self.layers {
            l.addRead(pRead)
        }
    }
    
}