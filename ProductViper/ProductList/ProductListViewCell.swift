//
//  ProductListViewCell.swift
//  ProductViper
//
//  Created by Okan on 6.09.2024.
//

import Foundation
import UIKit
import Kingfisher

class ProductListViewCell: UITableViewCell {
    public static let reuseID = "ProductListViewCell"
    
    private var image: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
       return image
    }()
    
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.textAlignment = .left
        label.numberOfLines = .zero
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let price: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
   
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureCell()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureCell()
    }
 
    
    
    private func configureCell() {
        
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(price)
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            
            image.heightAnchor.constraint(equalToConstant: 200),
            title.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 8),
            price.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 8)
        ])
        
        accessoryType = .disclosureIndicator
    }
   
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
    }
    
    func loadCell(with product: Product) {
        guard let imageURL = product.images?.first?.toURL() else { return }
        image.kf.indicatorType = .activity
        image.kf.setImage(with: imageURL)
        title.text = product.title
        price.text = product.price?.toCurrency()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
