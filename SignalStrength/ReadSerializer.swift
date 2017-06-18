//
//  ReadSerializer.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 17/06/17.
//  Copyright © 2017 Henrique do Prado Linhares. All rights reserved.
//

import Foundation
import RealmSwift

class ReadSerializer{

    static func readsToJson(reads:Results<Read>)->[String:AnyObject]{
        var arr = [String:AnyObject]()
        arr["count"] = reads.count
        var i = 0
        for r:Read in reads{
            arr["\(i)"] = r.toJson()
            i = i + 1
        }
        return arr
    }

}
