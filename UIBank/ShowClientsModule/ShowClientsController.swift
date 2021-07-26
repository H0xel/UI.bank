import UIKit

struct PhoneFormater {
    func format(phone: Phone) -> String {
        return "\(phone.countryCode) \(phone.numberPhone)"
    }
}

class ShowClientsController: UITableViewController {
    
    var clientAssembly: ClientDetailModuleAssembly!
    
    var bank: Bank!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        refresh(sender: self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bank.users().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tittle", for: indexPath)
        
        let user = bank.users()[indexPath.row]
        cell.textLabel?.text = user.name + " " + user.lastName
        cell.textLabel?.numberOfLines = 0
        let phoneFormater = PhoneFormater()
        cell.detailTextLabel?.text = phoneFormater.format(phone: user.phone)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func refresh(sender: AnyObject) {
        self.tableView.reloadData()
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ShowDetail" {
//            if let indexPath = self.tableView.indexPathForSelectedRow {
//
//                let clientDetailsVC = segue.destination as! ClientDetailVC
//
//                clientDetailsVC.fullnameTittle = clients[indexPath.row].name + " " + clients[indexPath.row].secondName + " " + clients[indexPath.row].lastName
//
//                clientDetailsVC.emailTittle = clients[indexPath.row].email
//
//                clientDetailsVC.mobilePhoneNumberTittle = String(clients[indexPath.row].phone.countryCode) + String(clients[indexPath.row].phone.numberPhone)
//
//                clientDetailsVC.adressTittle = clients[indexPath.row].address.country + " " + clients[indexPath.row].address.city + " " + clients[indexPath.row].address.street
//            }
//        }
//    }
}

