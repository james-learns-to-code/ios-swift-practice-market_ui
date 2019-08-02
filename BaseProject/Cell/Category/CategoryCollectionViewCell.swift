//
//  CategoryCollectionViewCell.swift
//  BaseProject
//
//  Created by leedongseok on 02/08/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: Interface
    
    func configure(name: String?) {
        nameLabel.text = name
    }
    
    override var isSelected: Bool {
        didSet {
            nameLabel.textColor = isSelected ? .blue : .gray
            lineView.isHidden = !isSelected
        }
    }
    
    static func getSize(name: String?) -> CGSize {
        let fontAttr = [NSAttributedString.Key.font: nameLabelFont]
        let labelSize = name?.boundingRect(
            with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0),
            options: .usesLineFragmentOrigin,
            attributes: fontAttr,
            context: nil).size ?? .zero
        return CGSize(
            width: CGFloat(Int(labelSize.width + CategoryCollectionViewCell.marginSize.width)),
            height: CGFloat(Int(labelSize.height + CategoryCollectionViewCell.marginSize.height)))
    }
    
    // MARK: UI
    
    private static let nameLabelFont = UIFont.preferredFont(forTextStyle: .caption2)
    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.font = CategoryCollectionViewCell.nameLabelFont
        view.textColor = .gray
        view.textAlignment = .center
        return view
    }()
    
    private let lineHeight: CGFloat = 2
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.isHidden = true
        return view
    }()
    
    private static let marginSize = CGSize(width: 8, height: 20)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setup() {
        contentView.addSubviewWithFullsize(nameLabel)
        
        contentView.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lineView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            lineView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            lineView.heightAnchor.constraint(equalToConstant: lineHeight),
            lineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -lineHeight)
            ])
    }
}
