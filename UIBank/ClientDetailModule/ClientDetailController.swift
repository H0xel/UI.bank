//
//  ClientDetailVC.swift
//  UIBank
//
//  Created by Ivan Amakhin on 14.07.2021.
//


import UIKit

struct ProductItem {
    let productName: String
    let prodyctType: String
}

struct ClientDetailState {
    let products: [ProductItem]
}

protocol ClientPresenterView: AnyObject {
    func displayLabels(fullname: String, phoneNumber: String, email: String, adress: String)
    var currentState: ClientDetailState? { get set }
}

class ClientDetailVC: UIViewController {
    
    var presenter: ClientDetailPresenter!
    var currentState: ClientDetailState? {
        didSet {
            productTableView.reloadData()
        }
    }
    
    @IBOutlet weak var clientFullNameLabel: UILabel!
    @IBOutlet weak var clientMobileNumberLabel: UILabel!
    @IBOutlet weak var clientEmailLabel: UILabel!
    @IBOutlet weak var clientAdressLabel: UILabel!
    @IBOutlet weak var productTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter.viewWillAppeared()
    }
    
    @IBAction func createDepositButton() {
        presenter.createDepositButtonTapped()
    }
}

extension ClientDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentState?.products.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = currentState?.products[indexPath.row].productName
        cell.detailTextLabel?.text = currentState?.products[indexPath.row].prodyctType
        return cell
    }
}

extension ClientDetailVC: ClientPresenterView {
    
    func displayLabels(fullname: String, phoneNumber: String, email: String, adress: String) {
        clientFullNameLabel.text = fullname
        clientMobileNumberLabel.text = phoneNumber
        clientEmailLabel.text = email
        clientAdressLabel.text = adress
        
        productTableView.register(ProductCell.self, forCellReuseIdentifier: "Cell")
        productTableView.dataSource = self
        productTableView.delegate = self
    }
}

extension ClientDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.cellTapped(indexPath: indexPath)
    }
}
