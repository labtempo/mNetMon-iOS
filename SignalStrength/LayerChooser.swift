//
//  LayerChooser.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 20/04/17.
//  Copyright © 2017 Henrique do Prado Linhares. All rights reserved.
//

import Foundation
import MapKit

class LayerChooser{

    static func chooseLayer(cameraAltitude:CLLocationDistance)->Layer?{
        let layers = Layer.all()
        for layer in layers{
            if layer.canBeUsedWithCameraAltitude(cameraAltitude){
                return layer
            }
        }
        return nil
    }

}