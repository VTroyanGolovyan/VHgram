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

class MessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    let dialogModel = DialogModel()
    @IBOutlet weak var dialogName: UILabel!
    @IBAction func backBtn(_ sender: Any) {
        switchAppTabBar()
    }
    @IBOutlet weak var inputField: UITextField!
    @IBAction func sendBtn(_ sender: Any) {
    }
    
    @IBOutlet weak var messagesTable: UITableView!
    @IBOutlet weak var sendPanel: UIView!
    
    static func storyBoardInstance() -> MessagesViewController? {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MessagesViewController") as? MessagesViewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesTable.delegate = self
        messagesTable.dataSource = self
        messagesTable.register(UINib(nibName: DialogTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: DialogTableViewCell.reuseId)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.inputField.delegate = self
        
        messagesTable.rowHeight = 90
        dialogModel.dialogNameDelegate = dialogName
        dialogModel.dialogMessagesDelegate = messagesTable
        
        sendPanel.layer.shadowColor =  UIColor.gray.cgColor
        sendPanel.layer.shadowOpacity = 0.8
        sendPanel.layer.shadowRadius = 4
        
        inputField.layer.borderColor = UIColor.lightGray.cgColor
        
        inputField.attributedPlaceholder = makeAttributedPlaceholder(text: "Message text")
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
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dialogModel.refetchData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
