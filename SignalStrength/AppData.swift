//
//  AppData.swift
//  Location
//
//  Created by Henrique do Prado Linhares on 18/11/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import Foundation
import RealmSwift

/*
Singleton responsable for the management of the reads during the app execution
*/
class AppData{
    
    static let sharedInstance = AppData()
    
    var locationReader = LocationReader()
    
    func createEmptyLayers(){
        LayerFactory().createEmptyLayers()
    }
    
    func addRead(pRead:Read){
        
    
    }
    
}