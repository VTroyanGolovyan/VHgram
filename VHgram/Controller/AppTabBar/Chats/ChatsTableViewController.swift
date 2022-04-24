//
//  ChatsTableViewController.swift
//  VHgram
//
//  Created by Владислав on 13.04.2022.
//

import UIKit

class ChatsTableViewController: UITableViewController {
    
    var dataModel = ChatsModel()
    var viewDelegate: AppTabBarViewControllerDelegate?
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        tableView = UITableView(frame: self.view.frame)
        tableView.backgroundColor = .lightGray
        
        tableView.rowHeight = 80
        self.tableView.allowsSelection = true
        tableView.separatorInset =  UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: ChatTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: ChatTableViewCell.reuseId)
        dataModel.chatsViewDelegate = tableView
        self.navigationItem.title = "Chats"
        self.navigationController?.navigationBar.backgroundColor = UIColor.darkGray
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataModel.Count()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.reuseId, for: indexPath) as! ChatTableViewCell
        cell.fillCell(chat: dataModel.GetChat(index: indexPath.row))
        if cell.newMsg.text == "0" {
            cell.newMsg.isHidden = true
        } else {
            cell.newMsg.isHidden = false
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ApplicationGlobals.activeDialog = dataModel.GetChat(index: indexPath.row)["dialog_table"] ?? ""
        self.viewDelegate?.switchChatView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataModel.referchData()
    }

}
