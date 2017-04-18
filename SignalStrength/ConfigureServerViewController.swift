//
//  ConfigureServerViewController.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 18/04/17.
//  Copyright © 2017 Henrique do Prado Linhares. All rights reserved.
//

import UIKit

class ConfigureServerViewController: UIViewController, UITextFieldDelegate{
    
    private var serverAddress:String = ""

    @IBOutlet weak var serverAddressTextField: UITextField!
    
    @IBAction func closeButtonAct(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBOutlet weak var uiConsole: UITextView!

    @IBOutlet weak var saveAndCloseButton: UIButton!
    
    @IBAction func connectButtonAct(sender: AnyObject) {
        if (serverAddressTextField.text == ""){
            AlertController.presentAlert("Server Address Empty", message: "Please insert a server address")
        } else {
            self.uiConsolePrint("Trying to connect to: http://"+self.serverAddressTextField.text!)
            Server.searchForServer(self.serverAddressTextField.text!) { (success, servername) in
                if success{
                    self.uiConsolePrint("Connected to server")
                    self.saveAndCloseButton.enabled = true
                    self.serverAddress = self.serverAddressTextField.text!
                } else {
                    self.uiConsolePrint("Cannot connect to server")
                    self.uiConsolePrint("Please check your internet connection and server address")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        self.uiConsole.text = ""
        self.saveAndCloseButton.enabled = false
    }
    
    //dismiss keyboard on return button
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //Dismiss keyboard when a tap is recognized
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func uiConsolePrint(str:String!){
        self.uiConsole.text = self.uiConsole.text + "\(str!)\n"
        let bottomOffset = CGPointMake(0, self.uiConsole.contentSize.height - self.uiConsole.bounds.size.height)
        self.uiConsole.setContentOffset(bottomOffset, animated: false)
        
    }
    
    
    @IBAction func saveAndCloseButtonAct(sender: AnyObject) {
        Server.setServer(self.serverAddress)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}