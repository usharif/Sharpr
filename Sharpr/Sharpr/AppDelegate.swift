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
        controller = DualSlideMenuViewController(mainViewController: mainView!, leftMenuViewController: leftView!)
        
        let closeButton = UIButton(frame: CGRect(x: 140, y: (leftView?.view.bounds.height)! - 50, width: 10, height: 10))
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(UIColor.blue, for: .normal)
        closeButton.sizeToFit()
        closeButton.addTarget(self, action: #selector(AppDelegate.closeButtonTapped(sender:)), for: .touchUpInside)
        leftView?.view.addSubview(closeButton)
        
        let helpButton = UIButton(frame: CGRect(x: 30, y: 30, width: 10, height: 10))
        helpButton.setTitle("Help", for: .normal)
        helpButton.setTitleColor(UIColor.blue, for: .normal)
        helpButton.sizeToFit()
        helpButton.addTarget(self, action: #selector(AppDelegate.helpButtonTapped(sender:)), for: .touchUpInside)
        mainView?.view.addSubview(helpButton)
        
        window!.rootViewController = controller
        window!.makeKeyAndVisible()
        
        controller!.leftSideOffset = 700
        controller!.addSwipeGestureInSide(viewController: leftView!, direction: .left)
        
        return true
    }
    
    func closeButtonTapped(sender: UIButton) {
        controller!.toggle(swipeDirection: "left")
    }
    
    func helpButtonTapped(sender: UIButton) {
        controller!.toggle(swipeDirection: "right")
    }

}

