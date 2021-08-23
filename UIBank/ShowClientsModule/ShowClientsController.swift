import UIKit
struct ShowClientItem {
    let fullname: String
}

struct ShowClientState {
    let clients: [ShowClientItem]
}

protocol ShowClientsView: AnyObject {
    var currentState: ShowClientState? {get set}
}

class ShowClientsController: UITableViewController, ShowClientsView {
    
    var currentState: ShowClientState? {
        didSet {
            tableView.reloadData()
        }
    }
    
    var presenter: ShowClientPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter.viewWillAppeared()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentState?.clients.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tittle", for: indexPath)
        cell.textLabel?.text = currentState?.clients[indexPath.row].fullname
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.cellTapped(indexPath: indexPath)
    }
}

