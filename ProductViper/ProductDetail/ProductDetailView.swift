//
//  ProductDetailView.swift
//  ProductViper
//
//  Created by Okan on 11.10.2024.
//

import Foundation
import UIKit
import Kingfisher

protocol ProductDetailViewProtocol {
    var presenter: ProductDetailPresenterInput? { get set }
}

protocol ProductDetailViewOutputProtocol: AnyObject {
    func handleOutput(with result: ProductDetailViewOutput)
}

class ProductDetailView: UIViewController, ProductDetailViewProtocol {
    var presenter: ProductDetailPresenterInput?
    
    private var activityIndicatorView: UIActivityIndicatorView =  {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        return indicator
    }()
    
    private var image: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
       return image
    }()
    
    let productTitle: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productDescription: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .label.withAlphaComponent(0.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isHidden = true
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        presenter?.viewDidload()
    }
    
    override func loadView() {
        super.loadView()
        addSubviews()
    }
}

extension ProductDetailView {
    private func addSubviews() {
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(productTitle)
        stackView.addArrangedSubview(productDescription)
        
        view.addSubview(stackView)
        view.addSubview(activityIndicatorView)
        makeConstraint()
    }
    
    private func makeConstraint() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            image.heightAnchor.constraint(equalToConstant: 200),

            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}

extension ProductDetailView: ProductDetailViewOutputProtocol {
    func handleOutput(with result: ProductDetailViewOutput) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }

            switch result {
            case .update(let product):
                loadProduct(with: product)
            case .error(let error):
                print("Error: ", error.localizedDescription)
            }
        }
    }
    
    private func loadProduct(with product: Product) {
        guard let imageURL = product.images?.first?.toURL() else { return }
        activityIndicatorView.isHidden = true
        stackView.isHidden = false
        
        setImage(with: imageURL, to: image)
        setLabels(with: product)
    }
    
    private func setImage(with url: URL, to imageView: UIImageView) {
        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage,
                .loadDiskFileSynchronously
            ])
    }
    
    private func setLabels(with product: Product) {
        productTitle.text = product.title
        productDescription.text = product.description
    }
}
