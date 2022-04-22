import UIKit

class ContactsTableViewController: UITableViewController,  UISearchResultsUpdating {
    
    var resultSearchController = UISearchController()
    
    var dataModel = ContactsModel()
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        tableView = UITableView(frame: self.view.frame)
        tableView.backgroundColor = .lightGray
        
        tableView.rowHeight = 80
        
        tableView.separatorInset =  UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: ContactsTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: ContactsTableViewCell.reuseId)
        dataModel.contactsViewDelegate = tableView
        self.navigationItem.title = "Contacts"
        self.navigationController?.navigationBar.backgroundColor = UIColor.darkGray
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        resultSearchController = ({
                let controller = UISearchController(searchResultsController: nil)
                controller.searchResultsUpdater = self
                controller.dimsBackgroundDuringPresentation = false
                controller.searchBar.sizeToFit()

                tableView.tableHeaderView = controller.searchBar

                return controller
            })()

    }
    
    func updateSearchResults(for searchController: UISearchController) {
        dataModel.filter(search: searchController.searchBar.text!)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  (resultSearchController.isActive) {
            return self.dataModel.filteredCount()
        }
        return self.dataModel.Count()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactsTableViewCell.reuseId, for: indexPath) as! ContactsTableViewCell
        if (resultSearchController.isActive) {
            cell.fillCell(contact: dataModel.filteredContact(index: indexPath.row))
        } else {
            cell.fillCell(contact: dataModel.GetContact(index: indexPath.row))
        }
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataModel.refetchData()
    }

}
