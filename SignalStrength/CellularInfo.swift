//
//  CarrierInfo.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 07/12/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import Foundation
import CoreTelephony
import UIKit

class CellularInfo{

    private let netInfo = CTTelephonyNetworkInfo()

    func getCarrierName()->String{
        return (self.netInfo.subscriberCellularProvider?.carrierName)!
    }
    
    func getSignalStengthInASU()->Double{
        return SignalConverter.DBMtoASU(self.getSignalStrength()!)
    }
    
    func getSignalStengthInDBM()->Double{
        return self.getSignalStrength()!
    }
    
    // Returns DBM value
    private func getSignalStrength()->Double?{
        let app = UIApplication.sharedApplication()
        let subViews = app.valueForKey("statusBar")?.valueForKey("foregroundView")?.subviews
        var dataNetworkItemView:NSObject
        for var subview in subViews!{
            if (subview.isKindOfClass(NSClassFromString("UIStatusBarSignalStrengthItemView")!)){
                dataNetworkItemView = subview
                let signalStrength = dataNetworkItemView.valueForKey("signalStrengthRaw") as! Double
                return signalStrength
            }
        }
        return nil
    }

}