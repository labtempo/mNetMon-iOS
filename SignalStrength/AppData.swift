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
        let realm = try! Realm()
        let layers = realm.objects(Layer)
        for layer in layers{
            layer.addRead(pRead)
        }
    }
    
}