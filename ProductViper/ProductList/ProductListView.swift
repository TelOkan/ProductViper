//
//  ProductListView.swift
//  ProductViper
//
//  Created by Okan on 2.09.2024.
//

import Foundation
import UIKit

// ViewController
// protocol
// reference presenter

protocol ProductListViewProtocol {
    var presenter: ProductListPresenterInput? { get set }
}

protocol ProductListViewOutputProtocol {
    func handleOutput(with result: ProductListViewOutput)
}

class ProductListViewController: UIViewController, ProductListViewProtocol {
    var presenter: ProductListPresenterInput?
    var products: [Product] = []
        
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(ProductListViewCell.self, forCellReuseIdentifier: ProductListViewCell.reuseID)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isHidden = true
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .systemGray5
        table.layer.cornerRadius = 8
        table.layer.masksToBounds = true
        table.layer.shadowRadius = 4
        table.layer.shadowOpacity = 0.25
        table.layer.shadowColor = UIColor.gray.cgColor
        table.layer.shadowOffset = .init(width: 0, height: 4)
        return table
    }()
    
    private var activityIndicatorView: UIActivityIndicatorView =  {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        return indicator
    }()
    
    override func loadView() {
        super.loadView()
        
        addSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        presenter?.viewDidload()
        
        title = "Products"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    
}

//MARK: - Prepare subviews
extension ProductListViewController {
    private func addSubviews() {
        view.backgroundColor = .systemGray5
        view.addSubview(tableView)
        view.addSubview(activityIndicatorView)
        makeConstraint()
    }
    
    private func makeConstraint() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        tableView.contentInset = .init(top: 0, left: 0, bottom: 16, right: 0)
        
        tableView.tableHeaderView = UIView() //to close first item seperator where top.
    }
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let productCell = tableView.dequeueReusableCell(withIdentifier: ProductListViewCell.reuseID, for: indexPath) as? ProductListViewCell else {
            return UITableViewCell()
        }
        productCell.loadCell(with: products[indexPath.row])
        productCell.selectionStyle = .none
        return productCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = products[indexPath.row].id else { return }
        presenter?.didSelectRow(with: id)
    }
}

//MARK: - ProductListViewOutput
extension ProductListViewController: ProductListViewOutputProtocol {
    func handleOutput(with result: ProductListViewOutput) {
        switch result {
        case .update(let products):
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                activityIndicatorView.stopAnimating()
                activityIndicatorView.isHidden = true
                tableView.isHidden = false
                
                self.products = products
                self.tableView.reloadData()
            }
        case .error(let _):
            print("error")
        }
    }
}
