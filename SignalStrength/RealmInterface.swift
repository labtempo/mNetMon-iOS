//
//  RealmInterface.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 11/09/16.
//  Copyright © 2016 Henrique do Prado Linhares. All rights reserved.
//

import Foundation
import RealmSwift

class RealmInterface{

    static let sharedInstance = RealmInterface()
    
    private let realmInstance = try! Realm()

    func getRealmInstance()->Realm{
        return realmInstance
    }

}