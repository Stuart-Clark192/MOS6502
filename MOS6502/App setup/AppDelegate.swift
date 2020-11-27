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
        cpu2.memory.loadProg(with: "20 09 06 20 0c 06 20 12 06 a2 00 60 e8 e0 05 d0 fb 60 00".toUInt8Array(), startingFromAddress: 0x0600)
        cpu2.reset()
        cpu2.run()
        cpu2.p.printRepresentation()
        cpu2.x.printRepresentation()
        cpu2.memory.dumpMem(startingFromAddress: 0x0600)
    }


}

