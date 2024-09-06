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

enum ProductListViewOutput {
    case update(_ products: [Product])
    case error(_ error: Error)
}

protocol ProductListViewOutputProtocol {
    func handleOutput(with type: ProductListViewOutput)
}

class ProductListViewController: UIViewController, ProductListViewProtocol {
    var presenter: ProductListPresenterInput?
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isHidden = true
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
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

//MARK: - Prepare subviews
extension ProductListViewController {
    private func addSubviews() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(activityIndicatorView)
        
        makeConstraint()
    }
    
    private func makeConstraint() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

//MARK: - ProductListViewOutput
extension ProductListViewController: ProductListViewOutputProtocol {
    func handleOutput(with type: ProductListViewOutput) {
        switch type {
        case .update(let _):
            print("Update")
        case .error(let _):
            print("error")
        }
    }
}
