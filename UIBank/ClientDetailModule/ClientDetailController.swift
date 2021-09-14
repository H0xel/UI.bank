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
    
    let stackView = UIStackView()
    let clientFullNameLabel = UILabel()
    let clientMobileNumberLabel = UILabel()
    let clientEmailLabel = UILabel()
    let clientAdressLabel = UILabel()
    let productTableView = UITableView()
    let createDepositButton = UIButton()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        presenter.viewWillAppeared()
        
        productTableView.register(ProductCell.self, forCellReuseIdentifier: "NewCell")
        productTableView.dataSource = self
        productTableView.delegate = self
    }
    
    @objc func chooseProductButtonTap() {
        presenter.chooseProductButtonTapped()
    }
}

extension ClientDetailVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentState?.products.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productTableView.dequeueReusableCell(withIdentifier: "NewCell", for: indexPath)
        cell.textLabel?.text = currentState?.products[indexPath.row].productName
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        cell.detailTextLabel?.text = currentState?.products[indexPath.row].prodyctType
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
        return cell
    }
}

extension ClientDetailVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.cellTapped(indexPath: indexPath)
        productTableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ClientDetailVC: ClientPresenterView {
    
    func displayLabels(fullname: String, phoneNumber: String, email: String, adress: String) {
        clientFullNameLabel.text = fullname
        clientMobileNumberLabel.text = phoneNumber
        clientEmailLabel.text = email
        clientAdressLabel.text = adress
        
        viewsAdded()
        setupAdded()
    }
    
    func viewsAdded() {
        view.addSubview(stackView)
        stackView.addSubview(clientFullNameLabel)
        stackView.addSubview(clientEmailLabel)
        stackView.addSubview(clientAdressLabel)
        stackView.addSubview(clientMobileNumberLabel)
        stackView.addSubview(productTableView)
        stackView.addSubview(createDepositButton)
    }
    
    func setupAdded() {
        setupStackView()
        setupClientFullNameLabel()
        setupClientEmailLabel()
        setupClientAdressLabel()
        setupClientMobileNumberLabel()
        setupProductTableView()
        setupCreateDepositButton()
    }
    
    func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20)
            
        ])
    }
    
    func setupClientFullNameLabel() {
        clientFullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        clientFullNameLabel.font = UIFont.systemFont(ofSize: 14)
        
        NSLayoutConstraint.activate([
            clientFullNameLabel.topAnchor.constraint(equalTo: stackView.topAnchor),
            clientFullNameLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            clientFullNameLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            clientFullNameLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
    
    func setupClientEmailLabel() {
        clientEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        clientEmailLabel.font = UIFont.systemFont(ofSize: 14)
        
        NSLayoutConstraint.activate([
            clientEmailLabel.topAnchor.constraint(equalTo: clientFullNameLabel.topAnchor, constant: 20),
            clientEmailLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            clientEmailLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            clientEmailLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
    
    func setupClientAdressLabel() {
        clientAdressLabel.translatesAutoresizingMaskIntoConstraints = false
        clientAdressLabel.font = UIFont.systemFont(ofSize: 14)
        
        NSLayoutConstraint.activate([
            clientAdressLabel.topAnchor.constraint(equalTo: clientEmailLabel.topAnchor, constant: 20),
            clientAdressLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            clientAdressLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            clientAdressLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
    
    func setupClientMobileNumberLabel() {
        clientMobileNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        clientMobileNumberLabel.font = UIFont.systemFont(ofSize: 14)
        
        NSLayoutConstraint.activate([
            clientMobileNumberLabel.topAnchor.constraint(equalTo: clientAdressLabel.topAnchor, constant: 20),
            clientMobileNumberLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            clientMobileNumberLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            clientMobileNumberLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
    
    func setupProductTableView() {
        productTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productTableView.topAnchor.constraint(equalTo: clientMobileNumberLabel.topAnchor, constant: 40),
            productTableView.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            productTableView.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            productTableView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            productTableView.heightAnchor.constraint(lessThanOrEqualToConstant: 200)
        ])
    }
    
    func setupCreateDepositButton() {
        
        createDepositButton.translatesAutoresizingMaskIntoConstraints = false
        createDepositButton.setTitle("Создать продукт", for: .normal)
        createDepositButton.addTarget(self, action: #selector(chooseProductButtonTap), for: .touchUpInside)
        createDepositButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        createDepositButton.setTitleColor(.blue, for: .normal)
        createDepositButton.titleLabel?.textAlignment = .center
        
        NSLayoutConstraint.activate([
            createDepositButton.topAnchor.constraint(equalTo: productTableView.bottomAnchor, constant: 20),
            createDepositButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            createDepositButton.widthAnchor.constraint(lessThanOrEqualTo: stackView.widthAnchor)
        ])
    }
}


