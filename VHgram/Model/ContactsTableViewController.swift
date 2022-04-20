import UIKit

class ContactsTableViewController: UITableViewController {
    
    var dataModel = ContactsModel()
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        tableView = UITableView(frame: self.view.frame)
        tableView.backgroundColor = .lightGray
        
        tableView.rowHeight = 80
        
        tableView.separatorInset =  UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        //self.view = tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: ContactsTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: ContactsTableViewCell.reuseId)
        dataModel.contactsViewDelegate = tableView
        self.navigationItem.title = "Contacts"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.dataModel.Count()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactsTableViewCell.reuseId, for: indexPath) as! ContactsTableViewCell
        cell.fillCell(contact: dataModel.GetContact(index: indexPath.row))
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
