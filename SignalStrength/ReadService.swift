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

class ReadService{
    
    static func getReadsInArea(topLeft: CLLocationCoordinate2D, bottomRight: CLLocationCoordinate2D, layer:Layer)->[Read]{
        if (Server.exists()){
            return requestReadsInArea(topLeft, bottomRight: bottomRight, layerId: layer.id)
        }
        return [Read]()
    }
    
    static private func requestReadsInArea(topLeft: CLLocationCoordinate2D, bottomRight: CLLocationCoordinate2D, layerId:Int)->[Read]{
        let serverAddress = Server.getServer()?.address
        let address = AppConstants.NTW_HTTP_PREFIX + serverAddress! + AppConstants.NTW_REST_READS
        let params = generateParams(topLeft, bottomRight: bottomRight, layerId: layerId)
        print("sending request...")
        print(address)
        Alamofire.request(.GET, address, parameters: params).responseJSON {
            response in
            print(response)
        }
        return [Read]()
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
