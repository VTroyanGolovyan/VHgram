import UIKit

class ContactsTableViewController: UITableViewController,  UISearchResultsUpdating {
    
    var resultSearchController = UISearchController()
    
    var dataModel = ContactsModel()
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        tableView = UITableView(frame: self.view.frame)
        tableView.backgroundColor = .lightGray
        tableView.rowHeight = CGFloat(CustomSettings.contactsTableRowHeight)
        tableView.separatorInset =  UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .always
        tableView.register(UINib(nibName: ContactsTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: ContactsTableViewCell.reuseId)
        dataModel.contactsViewDelegate = tableView
        
        resultSearchController = ({
                let controller = UISearchController(searchResultsController: nil)
                controller.searchResultsUpdater = self
                controller.searchBar.sizeToFit()
                tableView.tableHeaderView = controller.searchBar
                return controller
            })()
        
        self.navigationItem.title = TabsSettings.contactsTabName
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.darkGray]
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        dataModel.filter(search: searchController.searchBar.text!)
    }

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
        cell.dataSource = dataModel
        if (resultSearchController.isActive) {
            cell.fillCell(
                contact: dataModel.filteredContact(index: indexPath.row),
                isContact: dataModel.isUserContact(id: dataModel.filteredContact(index: indexPath.row)["id"] ?? ApplicationGlobals.undefinedUserId))
        } else {
            cell.fillCell(contact: dataModel.GetContact(index: indexPath.row), isContact: dataModel.isUserContact(id: dataModel.GetContact(index: indexPath.row)["id"] ?? ApplicationGlobals.undefinedUserId))
        }
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataModel.refetchData()
    }

}
