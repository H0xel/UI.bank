import UIKit

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
        let phoneFormater = Formater()
        cell.detailTextLabel?.text = phoneFormater.format(phone: user.phone)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func refresh(sender: AnyObject) {
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let formater = Formater()
        let user = bank.users()[indexPath.row]
        let vc = clientAssembly.viewcontroller
        
        vc.fullnameTittle = formater.format(fullname: user)
        vc.emailTittle = user.email
        vc.mobilePhoneNumberTittle = formater.format(phone: user.phone)
        vc.adressTittle = formater.format(adress: user.address)
        
        present(vc, animated: true, completion: nil)
    }
}

