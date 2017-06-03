//
//  ReadService.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 18/04/17.
//  Copyright © 2017 Henrique do Prado Linhares. All rights reserved.
//

import Foundation
import Alamofire
import MapKit
import SwiftyJSON

class ReadService{
    
    static func getReadsInArea(topLeft: CLLocationCoordinate2D, bottomRight: CLLocationCoordinate2D, layer:Layer)->[Read]{
        var reads = [Read]()
        if (Server.exists()){
            requestReadsInArea(topLeft, bottomRight: bottomRight, layerId: layer.id) { (success, json) in
                if (success){
                    print(json)
                    for (_, subJson):(String, JSON) in json{
                        let r = Read()
                        r.latitude = subJson["latitude"].doubleValue
                        r.longitude = subJson["longitude"].doubleValue
                        r.signalStrength = subJson["signalStrength"].doubleValue
                        reads.append(r)
                     }
                    print("$$ \(reads.count)")
                } else {
                    print("Error in request")
                }
            
            }
        }
        print(" $ \(reads.count)")
        return reads
    }
    
    static func requestReadsInArea(topLeft: CLLocationCoordinate2D, bottomRight: CLLocationCoordinate2D, layerId:Int, completionHandler: (Bool, JSON)->()){
        let serverAddress = Server.getServer()?.address
        let address = AppConstants.NTW_HTTP_PREFIX + serverAddress! + AppConstants.NTW_REST_READS
        let params = generateParams(topLeft, bottomRight: bottomRight, layerId: layerId)
        print("sending request...")
        print(address)
        Alamofire.request(.GET, address, parameters: params).responseJSON { response in
            switch response.result{
            case .Success:
                let json = JSON(response.result.value!)
                completionHandler(true, json)
                break
            case.Failure:
                completionHandler(false, nil)
                break
            }
            
        }
    }
    
    static private func generateParams(topLeft: CLLocationCoordinate2D, bottomRight: CLLocationCoordinate2D, layerId:Int)->[String:AnyObject]{
        return [
            "topLeftLatitude": topLeft.latitude.description,
            "topLeftLongitude": topLeft.longitude.description,
            "bottomRightLatitude": bottomRight.latitude.description,
            "bottomRightLongitude": bottomRight.longitude.description,
            "layerID": layerId.description
        ];
    }

}
