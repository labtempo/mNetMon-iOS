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
    
    private var isCurrentlyReading:Bool
    
    init(){
        self.isCurrentlyReading = false
        
        //cria o layer 01
        var layer01 = Layer(pID: 1, pMinDelta: 0, pMaxDelta: 1, pPrecisionCoeficient: 0.002)
        
        let readExamples = ReadsTests().getReads()
        for r:Read in readExamples {
            layer01.addRead(r)
        }
        
        self.layers.append(layer01)
    }
    
    
    func getIsCurrentlyReading()->Bool{
        return self.isCurrentlyReading
    }
    
    func setIsCurrentlyReading(pBool:Bool){
        self.isCurrentlyReading = pBool
    }
    
    func changeIsCurrentlyReadingStatus(){
        self.isCurrentlyReading = !self.isCurrentlyReading
    }
    
    func addRead(pRead:Read){
        layers[0].addRead(pRead)
    }
    
}