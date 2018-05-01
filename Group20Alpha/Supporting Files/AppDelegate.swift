//
//  AppDelegate.swift
//  Group20Alpha
//
//  Created by Ashley Moore on 3/20/18.
//  Copyright © 2018 Group 20. All rights reserved.
//

import UIKit
import Firebase
import CoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let defaults = UserDefaults.standard
    var userIsLoggedIn: Bool?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        //Uncomment this stuff to make the stay logged in stuff kind of work. Nav controller won't show up here now, though.
        //Feel free to tinker with this if you think you'll have better luck than I have for hte last 20 minutes
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let navController = storyboard.instantiateInitialViewController() as! UINavigationController
//        self.window?.rootViewController = navController
//        let loginController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
//        let landingController = storyboard.instantiateViewController(withIdentifier: "LandingController")
        FirebaseApp.configure()
        userIsLoggedIn = defaults.bool(forKey: "UserIsLoggedIn")
        
        //Uncomment these lines to get things back to normal!
//        if userIsLoggedIn == true {
//            self.window?.rootViewController = landingController
//            self.window?.makeKeyAndVisible()
//        } else {
//            self.window?.rootViewController = loginController
//            self.window?.makeKeyAndVisible()
//        }
        
        return true
    }
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

