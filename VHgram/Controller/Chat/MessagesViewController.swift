//
//  MessagesViewController.swift
//  VHgram
//
//  Created by Владислав on 23.04.2022.
//

import UIKit

class MessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let dialogModel = DialogModel()
    @IBOutlet weak var DialogName: UILabel!
    @IBAction func backBtn(_ sender: Any) {
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
}
