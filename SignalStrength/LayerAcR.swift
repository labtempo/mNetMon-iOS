//
//  LayerAcR.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 12/12/16.
//  Copyright © 2016 Henrique do Prado Linhares. All rights reserved.
//

import Foundation
import RealmSwift

class LayerAcR{
    
    static func all()->Results<Layer>{
        let realm = try! Realm()
        return realm.objects(Layer.self)
    }
    
    static func filter(filtr:String)->Results<Layer>{
        let realm = try! Realm()
        return realm.objects(Layer.self).filter(filtr)
    }
    
}
