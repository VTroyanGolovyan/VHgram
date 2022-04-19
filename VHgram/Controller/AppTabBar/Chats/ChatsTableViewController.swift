//
//  ChatsTableViewController.swift
//  VHgram
//
//  Created by Владислав on 13.04.2022.
//

import UIKit

class ChatsTableViewController: UITableViewController {
    
    var chatsTableView: UITableView!
    var dataModel = ChatsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatsTableView = UITableView(frame: self.view.frame)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        chatsTableView.backgroundColor = .lightGray
        
        chatsTableView.rowHeight = 80
        
        chatsTableView.separatorInset =  UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.view = chatsTableView
        chatsTableView.delegate = self
        chatsTableView.dataSource = self
        chatsTableView.register(UINib(nibName: ChatTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: ChatTableViewCell.reuseId)
        self.navigationItem.title = "Chats"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataModel.Count()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.reuseId, for: indexPath) as! ChatTableViewCell
        cell.fillCell(chat: dataModel.GetChat(index: indexPath.row))
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
