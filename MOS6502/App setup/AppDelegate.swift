//
//  AppDelegate.swift
//  MOS6502
//
//  Created by Stuart on 15/11/2020.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        runtest()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func runtest() {
        let mem = Memory(memorySize: 65535)
        let cpu2 = CPU(with: mem)
        cpu2.memory.loadProg(with: "18 f8 a9 99 69 99".toUInt8Array(), startingFromAddress: 0x0600)
        
//        cpu2.memory.loadProg(with: "a0 10 84 44 a2 01 b5 43".toUInt8Array(), startingFromAddress: 0x0600)
        
        cpu2.reset()
        cpu2.run(isDissasembleMode: true)
    }


}

