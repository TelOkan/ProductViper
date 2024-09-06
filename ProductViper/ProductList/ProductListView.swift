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
        table.isHidden = true

        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        presenter?.viewDidload()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
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
