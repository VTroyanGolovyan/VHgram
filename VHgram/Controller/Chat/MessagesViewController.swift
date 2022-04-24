//
//  MessagesViewController.swift
//  VHgram
//
//  Created by Владислав on 23.04.2022.
//

import UIKit

protocol MessagesViewControllerDelegate {
    func switchAppTabBar();
}

class MessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let dialogModel = DialogModel()
    @IBOutlet weak var DialogName: UILabel!
    @IBAction func backBtn(_ sender: Any) {
        switchAppTabBar()
    }
    @IBOutlet weak var inputField: UITextField!
    @IBAction func sendBtn(_ sender: Any) {
    }
    
    @IBOutlet weak var messagesTable: UITableView!
    
    static func storyBoardInstance() -> MessagesViewController? {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MessagesViewController") as? MessagesViewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesTable.delegate = self
        messagesTable.dataSource = self
        dialogModel.refetchData()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dialogModel.refetchData()
    }
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    private func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension MessagesViewController: MessagesViewControllerDelegate {
    func switchAppTabBar() {
        let app = AppTabBarViewController.storyBoardInstance()
        if app != nil {
            self.view.insertSubview((app?.view)!, at: 1)
            UIApplication.shared.keyWindow?.rootViewController = app
        }
    }
}
