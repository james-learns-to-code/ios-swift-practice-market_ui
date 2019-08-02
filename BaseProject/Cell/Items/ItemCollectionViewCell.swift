//
//  ItemCollectionViewCell.swift
//  BaseProject
//
//  Created by leedongseok on 02/08/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

final class ItemCollectionViewCell: UICollectionViewCell {
  
    static let labelHeight: CGFloat = 80

    // MARK: Interface
    func configure(imageUrlStr: String?, title: String?, promotion: String?, price: Double) {
        imageView.loader.setImageWithUrlString(imageUrlStr)
        promotionLabel.text = promotion
        titleLabel.text = title
        priceLabel.text = String(format: "$%.02f", price)
    }
    
    // MARK: UI
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var promotionLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.preferredFont(forTextStyle: .caption2)
        view.textColor = .blue
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.preferredFont(forTextStyle: .caption1)
        return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ItemCollectionViewCell.labelHeight)
            ])

        contentView.addSubview(promotionLabel)
        promotionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            promotionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            promotionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            promotionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10)
            ])
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleLabel.topAnchor.constraint(equalTo: promotionLabel.bottomAnchor, constant: 10)
            ])
 
        contentView.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
            ])
    }
}
