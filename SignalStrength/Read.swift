//
//  Readout.swift
//  Location
//
//  Created by Henrique do Prado Linhares on 18/11/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import RealmSwift
import SwiftyJSON

class Read: Object {

    dynamic var latitude:Double = 0.0
    dynamic var longitude:Double = 0.0
    dynamic var signalStrength:Double = 0.0
    dynamic var carrierName:String = ""
    dynamic var isSyncPending:Bool = true
    dynamic var date:NSDate = NSDate()
    
    func toString()->String{
        return "Read - Latitude: \(self.latitude) , Longitude: \(self.longitude) , Signal Strength: \(self.signalStrength) , Carrier name: \(self.carrierName)"
    }
    
    func toJson()->[String: AnyObject]{
        return [
            "read": [
                    "latitude" : self.latitude.description,
                    "longitude": self.longitude.description,
                    "signalStrength": self.signalStrength.description,
                    "carrierName" : self.carrierName,
                    "date" : self.date.description
            ]
        ]
    }
    
    /*
    func toJson()->JSON{
        let json:JSON = [
            "read": [
                "latitude" : self.latitude.description,
                "longitude": self.longitude.description,
                "signalStrength": self.signalStrength.description,
                "carrierName" : self.carrierName,
                "date" : self.date.description
            ]
        ]
        return json
    }*/
    
    
    
    /* Beginning of RealmSwift data manipulation Methods */
    static func all()->Results<Read> {
        let realm = try! Realm()
        return realm.objects(Read.self)
    }
    
    static func filter(query:String)->Results<Layer>{
        let realm = try! Realm()
        return realm.objects(Layer.self).filter(query)
    }
    /* End of RealmSwift data manipulation Methods */
    
}