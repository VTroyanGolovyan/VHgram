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
    @IBOutlet weak var dialogName: UILabel!
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
        messagesTable.register(UINib(nibName: DialogTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: DialogTableViewCell.reuseId)
        messagesTable.rowHeight = 90
        dialogModel.dialogNameDelegate = dialogName
        dialogModel.dialogMessagesDelegate = messagesTable
        dialogModel.refetchData()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dialogModel.messagesCnt();
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DialogTableViewCell.reuseId, for: indexPath) as! DialogTableViewCell
        cell.fillCell(data: dialogModel.getMessage(id: indexPath.row))
        return cell;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dialogModel.refetchData()
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
