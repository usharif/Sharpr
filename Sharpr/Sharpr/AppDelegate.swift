//
//  AppDelegate.swift
//  Sharpr
//
//  Created by Umair Sharif on 9/19/16.
//  Copyright © 2016 Sharpr. All rights reserved.
//

import UIKit
import DualSlideMenu

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyboard: UIStoryboard?
    var controller: DualSlideMenuViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey:Any]?) -> Bool {
        application.applicationSupportsShakeToEdit = true
        window = UIWindow(frame: UIScreen.main.bounds)
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        let leftView = storyboard?.instantiateViewController(withIdentifier: "HelpViewController")
        let mainView = storyboard?.instantiateViewController(withIdentifier: "MainViewController")
        let controller = DualSlideMenuViewController(mainViewController: mainView!, leftMenuViewController: leftView!)
        
        window!.rootViewController = controller
        window!.makeKeyAndVisible()
        
        controller.leftSideOffset = 700
        controller.toMain()
        controller.addSwipeGestureInSide(viewController: leftView!, direction: .left)
        
        return true
    }
    
    func helpButtonTapped(sender: UIButton){
        controller?.toggle(swipeDirection: "right")
    }

}

