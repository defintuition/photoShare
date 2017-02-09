//
//  AppDelegate.swift
//  Hipstagram
//
//  Created by Annie Tung on 2/6/17.
//  Copyright © 2017 Annie Tung. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        FIRApp.configure()
        
        
        let tabVC: UITabBarController = UITabBarController()
        tabVC.tabBar.tintColor = UIColor(red:1.00, green:0.84, blue:0.25, alpha:1.0)
        
        
        let categoriesTVC: CategoriesTableViewController = CategoriesTableViewController()
        let uploadVC: UploadViewController = UploadViewController()
        let userVC: LoginViewController = LoginViewController() 
        
        let firstNav: UINavigationController = UINavigationController(rootViewController: categoriesTVC)
        firstNav.navigationBar.barTintColor = UIColor(red:0.27, green:0.35, blue:0.39, alpha:1.0)
        firstNav.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        
        let secNav: UINavigationController = UINavigationController(rootViewController: uploadVC)
        secNav.navigationBar.barTintColor = UIColor(red:0.27, green:0.35, blue:0.39, alpha:1.0)
        secNav.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]

        

        let thirdNav: UINavigationController = UINavigationController(rootViewController: userVC)
        thirdNav.navigationBar.barTintColor = UIColor(red:0.27, green:0.35, blue:0.39, alpha:1.0)
        thirdNav.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        thirdNav.navigationBar.tintColor = .white
//
//        let firstNav: UINavigationController = UINavigationController(rootViewController: categ)
//        firstNav.navigationBar.barTintColor = UIColor(red:0.27, green:0.35, blue:0.39, alpha:1.0)
//        firstNav.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
//        
//        
//        let thirdNav: UINavigationController = UINavigationController(rootViewController: userVC)
//        thirdNav.navigationBar.barTintColor = UIColor(red:0.27, green:0.35, blue:0.39, alpha:1.0)
//        thirdNav.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]

        
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = tabVC
        
        let firstTabItemImage = #imageLiteral(resourceName: "gallery_icon")
        let secondTabItemImage = #imageLiteral(resourceName: "camera_icon")
        let thirdTabItemImage = #imageLiteral(resourceName: "user_icon")
        
        
        let tab1ItemInfo = UITabBarItem(title: "", image: firstTabItemImage, tag: 0)
        let tab2ItemInfo = UITabBarItem(title: "", image: secondTabItemImage, tag: 1)
        let tab3ItemInfo = UITabBarItem(title: "", image: thirdTabItemImage, tag: 2)
        
        tab1ItemInfo.setBadgeTextAttributes([NSForegroundColorAttributeName: UIColor.yellow], for: .selected)
        
        
        
        
        firstNav.tabBarItem = tab1ItemInfo
        firstNav.navigationBar.tintColor = UIColor(red:1.00, green:0.84, blue:0.25, alpha:1.0)
        secNav.tabBarItem = tab2ItemInfo
        thirdNav.tabBarItem = tab3ItemInfo
        thirdNav.navigationBar.tintColor = UIColor(red:1.00, green:0.84, blue:0.25, alpha:1.0)
        tabVC.viewControllers = [firstNav, secNav, thirdNav]

        
        self.window?.makeKeyAndVisible()
        
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

