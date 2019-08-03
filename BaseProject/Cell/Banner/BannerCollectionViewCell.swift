//
//  BannerCollectionViewCell.swift
//  BaseProject
//
//  Created by leedongseok on 01/08/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

final class BannerCollectionViewCell: UICollectionViewCell {
    typealias SelfClass = BannerCollectionViewCell
    
    static let topMargin: CGFloat = 10
    static let imageBottomMargin: CGFloat = 10
    static let labelHeight: CGFloat = 60

    // MARK: Interface
    
    func configure(imageUrlStr: String?, title: String?, subTitle: String?) {
        imageView.loader.setImageWithUrlString(imageUrlStr)
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
    
    static func getHeight(width: CGFloat) -> CGFloat {
        let imageHeight = width * 0.5
        let height = topMargin + imageHeight + labelHeight
        return height
    }

    // MARK: UI
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.preferredFont(forTextStyle: .caption1)
        return view
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.preferredFont(forTextStyle: .caption2)
        view.textColor = .gray
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
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: SelfClass.topMargin),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -SelfClass.labelHeight)
            ])

        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: SelfClass.imageBottomMargin)
            ])

        contentView.addSubview(subTitleLabel)
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            subTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
            ])
    }
}
