//
//  Server.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 18/04/17.
//  Copyright © 2017 Henrique do Prado Linhares. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire
import SwiftyJSON

class Server: Object{

    dynamic var address:String = ""
    
    static func exists()->Bool{
        let realm = try! Realm()
        if (realm.objects(Server.self).count == 0){
            return false
        } else {
            return true
        }
    }
    
    static func setServer(serverAddress:String){
        let realm = try! Realm()
        if (realm.objects(Server.self).count > 0){
            try! realm.write {
                realm.delete(realm.objects(Server.self))
            }
        }
        let server = Server()
        server.address = serverAddress
        try! realm.write{
            realm.add(server)
        }
    }
    
    static func getServer()->Server?{
        let realm = try! Realm()
        return realm.objects(Server.self).first
    }
    
    static func searchForServer(serverAddress:String, completionHandler: (Bool, String?) -> ()){
        let address = AppConstants.NTW_HTTP_PREFIX+serverAddress+AppConstants.NTW_REST_HANDSHAKE
        print(address)
        Alamofire.request(.GET, address, parameters:["format":"json"]).responseJSON { response in
            switch response.result{
            case .Success:
                completionHandler(true, getServerName(JSON(response.result.value!)))
                break
            case .Failure:
                completionHandler(false, nil)
                break
            }
        }
    }
    
    private static func getServerName(json:JSON)->String{
        if (json["table"]["response"] == "success"){
            return json["table"]["serverName"].stringValue
        }
        return ""
    }
    

}
