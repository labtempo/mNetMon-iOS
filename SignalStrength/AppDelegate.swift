//
//  AppDelegate.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 23/11/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        if (AppDAO.sharedInstance.databaseExists()){
            AppDAO.sharedInstance.readAppData()
            
            for layer:Layer in AppData.sharedInstance.layers{
                if layer.ID == 1 {
                    AppData.sharedInstance.layers[0].minDelta = 0
                    AppData.sharedInstance.layers[0].maxDelta = 0.040
                } else if layer.ID == 2 {
                    AppData.sharedInstance.layers[1].minDelta = 0.041
                    AppData.sharedInstance.layers[1].maxDelta = 0.1
                }
                else if layer.ID == 3 {
                    AppData.sharedInstance.layers[2].minDelta = 0.11
                    AppData.sharedInstance.layers[2].maxDelta = 0.231
                    
                } else if layer.ID == 4 {
                    AppData.sharedInstance.layers[3].minDelta = 0.232
                    AppData.sharedInstance.layers[3].maxDelta = 999999999999
                }
                
                else {
                    AppData.sharedInstance.layers[layer.ID - 1].minDelta = 999999999999
                    AppData.sharedInstance.layers[layer.ID - 1].maxDelta = 999999999999
                }
            }
            

            

            
        } else {
            AppDAO.sharedInstance.saveAppData()
            
            //Retire o comentario da linha abaixo para adicionar os testes na 
            //primeira inicialização do app
            //AppData.sharedInstance.setReads(ReadsTests().getReads())
            
            PListManager.sharedInstance.writePlist("Database", key: "databaseExists", data: true)
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
            AppDAO.sharedInstance.saveAppData()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
                AppDAO.sharedInstance.saveAppData()
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
            AppDAO.sharedInstance.saveAppData()
    }


}

