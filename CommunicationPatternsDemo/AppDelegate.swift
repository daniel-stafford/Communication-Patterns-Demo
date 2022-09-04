//
//  AppDelegate.swift
//  CommunicationPatternsDemo
//
//  Created by Il Capo on 04/09/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let myView = MyView()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = MyViewController()
        
        myView.didTapClosureButton = { message in
            print(message, "received inside app delegate")
        }
        
        return true
    }
}
