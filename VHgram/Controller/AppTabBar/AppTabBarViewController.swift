//
//  AppTabBarViewController.swift
//  VHgram
//
//  Created by Владислав on 13.04.2022.
//

import UIKit

class AppTabBarViewController: UITabBarController {
    
    
    var chatsTableViewController: UITableViewController!
    var contactsTableViewController: UIViewController!
    
    var dataModel = ChatsModel()
    
    static func storyBoardInstance() -> AppTabBarViewController? {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppTabBarViewController") as? AppTabBarViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        chatsTableViewController = ChatsTableViewController()
        chatsTableViewController.title="✉️"
        contactsTableViewController = UIViewController()
        contactsTableViewController.title="📔"
        let settings = UIViewController()
        settings.title="⚙️"
        
        setViewControllers([UINavigationController(rootViewController: chatsTableViewController), UINavigationController(rootViewController: contactsTableViewController), UINavigationController(rootViewController:  settings)], animated: true)
        
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = .black
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 32)], for: .normal)
       // tableView.rowHeight = 80
       // self.view.addSubview(tableView)
       // tableView.delegate = self
       // tableView.dataSource = self

       // tableView.register(UINib(nibName: ChatTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: ChatTableViewCell.reuseId)
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
