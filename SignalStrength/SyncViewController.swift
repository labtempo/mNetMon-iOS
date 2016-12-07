//
//  SyncViewController.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 06/11/16.
//  Copyright © 2016 Henrique do Prado Linhares. All rights reserved.
//

import UIKit

class SyncViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var serverAddressLabel: UITextField!

    @IBOutlet weak var statusUiView: UITextView!
    
    @IBOutlet weak var statusTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.serverAddressLabel.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        self.configuraStatusNaoSincronizando()
    }
    
    
    func configuraStatusNaoSincronizando(){
        self.statusUiView.backgroundColor = UIColor.redColor()
        self.statusTextView.text = "Não está sincronizando"
    }
    
    
    func configuraStatusProntoParaSincronizar(){
        self.statusUiView.backgroundColor = UIColor.orangeColor()
        self.statusTextView.text = "Pronto para sincronizar"
    }
    
    
    func configuraStatusSincronizando(){
        self.statusUiView.backgroundColor = UIColor.greenColor()
        self.statusTextView.text = "Está sincronizando"
    }
    
    func findServer(){
        Synchronizer.sharedInstance.findServer(serverAddressLabel.text!){ (success, servername) in
            if success{
                let alertController = UIAlertController(title: "Sucesso", message:"Conectado ao servidor \(servername!).", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                self.configuraStatusProntoParaSincronizar()
            } else {
                let alertController = UIAlertController(title: "Erro", message:"Não foi possível localizar o servidor.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                self.configuraStatusNaoSincronizando()
            }
        }

  
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        findServer()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
