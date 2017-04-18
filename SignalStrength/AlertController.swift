//
//  AlertController.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 17/04/17.
//  Copyright © 2017 Henrique do Prado Linhares. All rights reserved.
//

import Foundation
import UIKit

class AlertController{


    static func presentAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }


}