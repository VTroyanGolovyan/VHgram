//
//  AppTabBarViewController.swift
//  VHgram
//
//  Created by Владислав on 13.04.2022.
//

import UIKit

protocol AppTabBarViewControllerDelegate {
    func switchSignInController();
    func switchChatView();
}

class AppTabBarViewController: UITabBarController {
    
    
    var chatsTableViewController: ChatsTableViewController = ChatsTableViewController()
    var contactsTableViewController: ContactsTableViewController = ContactsTableViewController()
    
    
    static func storyBoardInstance() -> AppTabBarViewController? {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppTabBarViewController") as? AppTabBarViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatsTableViewController.title="✉️"
        chatsTableViewController.viewDelegate = self
        contactsTableViewController.title="📔"
        let settings = SettingsViewController()
        settings.title="⚙️"
        settings.delegate = self
        
        let profile = ProfileViewController()
        profile.title = "👤"
        
        self.setViewControllers([
            UINavigationController(rootViewController: chatsTableViewController),
            UINavigationController(rootViewController: contactsTableViewController),
            UINavigationController(rootViewController: profile),
            UINavigationController(rootViewController: settings)],
            animated: true)
       
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = .black
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 32)!], for: .normal)
        PollingWorker.runPolling()
        self.loadViewIfNeeded()
    }

}


extension AppTabBarViewController: AppTabBarViewControllerDelegate {
    func switchChatView() {
        let app = MessagesViewController.storyBoardInstance()
        if app != nil {
            self.view.insertSubview((app?.view)!, at: 1)
            UIApplication.shared.keyWindow?.rootViewController = app
        }
    }
    
    func switchSignInController() {
        let app = LoginViewController.storyBoardInstance()
        if app != nil {
            self.view.insertSubview((app?.view)!, at: 1)
            UIApplication.shared.keyWindow?.rootViewController = app
        }
    }
}
