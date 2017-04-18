//
//  ViewController.swift
//  Location
//
//  Created by Henrique do Prado Linhares on 09/10/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift
import Foundation

class WorldMapViewController: UIViewController {

    override func viewWillAppear(animated: Bool) {
        if !Server.exists() {
            AlertController.presentAlert("Not connected to server", message: "Please, connect to a server")
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
    }
    
    override func viewDidLoad() {
    }
    
    
}