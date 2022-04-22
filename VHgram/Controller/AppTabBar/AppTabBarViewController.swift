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
        chatsTableViewController.delegate = self
        contactsTableViewController.title="📔"
        let settings = SettingsViewController()
        settings.title="⚙️"
        settings.delegate = self
        
        let profile = ProfileViewController()
        profile.title = "👤"
        let news = UIViewController()
        news.title = "📰"
        setViewControllers([
            UINavigationController(rootViewController: chatsTableViewController),
            news,
            UINavigationController(rootViewController: contactsTableViewController),
            UINavigationController(rootViewController: profile),
            UINavigationController(rootViewController: settings)],
            animated: true)
        
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = .black
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 32)], for: .normal)
        PollingWorker.runPolling()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension AppTabBarViewController: AppTabBarViewControllerDelegate {
    func switchChatView() {
        var app = ChatViewController.storyBoardInstance()
        if app != nil {
            self.view.insertSubview((app?.view)!, at: 1)
            UIApplication.shared.windows.first?.rootViewController = app
        }
    }
    
    func switchSignInController() {
        var app = LoginViewController.storyBoardInstance()
        if app != nil {
            self.view.insertSubview((app?.view)!, at: 1)
            UIApplication.shared.windows.first?.rootViewController = app
        }
    }
}
