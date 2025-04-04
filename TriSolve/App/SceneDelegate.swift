//
//  SceneDelegate.swift
//  TriSolve
//
//  Created by Edward on 03.04.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let rootVC = MainMenuViewController()
        let navController = UINavigationController(rootViewController: rootVC)
        
        window.rootViewController = navController
        self.window = window
        window.makeKeyAndVisible()
    }
}
