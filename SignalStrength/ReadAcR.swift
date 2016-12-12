//
//  ReadAcR.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 12/12/16.
//  Copyright © 2016 Henrique do Prado Linhares. All rights reserved.
//

import Foundation
import RealmSwift

class ReadAcR{
    
    static func all()->Results<Read>{
        let realm = try! Realm()
        return realm.objects(Read.self)
    }


}
