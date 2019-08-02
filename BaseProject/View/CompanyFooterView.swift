//
//  CompanyFooterView.swift
//  BaseProject
//
//  Created by leedongseok on 02/08/2019.
//  Copyright © 2019 Good Effect. All rights reserved.
//

import UIKit

protocol CompanyFooterViewDelegate: class {
    func didTapExpandButton(_ sender: CompanyFooterView)
}

final class CompanyFooterView: UIView {
    weak var delegate: CompanyFooterViewDelegate?
    
    static let shrinkHeight: CGFloat = 100
    static let height: CGFloat = 200
    
    // MARK: Interface
    
    var isShrink: Bool {
        return (frame.size.height == CompanyFooterView.height)
            ? false : true
    }
    
    func updateHeight(isShrink: Bool) {
        let width = frame.width
        let height = isShrink ? CompanyFooterView.shrinkHeight : CompanyFooterView.height
        frame.size = CGSize(width: width, height: height)
        descriptionLabel.numberOfLines = isShrink ? 2 : 0
        setNeedsLayout()
    }
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateHeight(isShrink: isShrink)
    }
    
    // MARK: Setup
    private func setup() {
        backgroundColor = .clear
        
        titleLabel.text = "COMPANY"
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
            ])
        
        descriptionLabel.text = """
        대구가 후반 시작과 함께 히우두를 투입하며 승부수를 띄웠다. 그래도 대구의 공격은 활로를 찾지 못했다. 후반 초반 3대2 역습 상황도 세징야와 히우두의 호흡이 맞지 않아 무산됐고 이렇다할 장면을 만들지 못했다.
        
        서울에 다시 기회가 넘어갔고 후반 14분 박동진이 추가골을 터뜨렸다. 2분 전 프리키가 상황서 시도한 왼발 슈팅이 골대를 때려 아쉬움을 삼켰던 박동진이지만 두 번째 기회는 놓치지 않았다. 고요한이 오른쪽에서 올려준 크로스를 문전서 머리로 받아넣어 2-0을 만들었다.
        
        퇴장이 변수로 떠올랐다. 후반 17분 대구 수비수 김우석이 박주영을 막는 과정에서 두 번째 경고를 받아 퇴장을 당했고 서울도 25분 고광민이 히우두에게 거친 태클을 해 퇴장당했다.
"""
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
            ])
        
        addSubview(expandButton)
        expandButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            expandButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            expandButton.rightAnchor.constraint(equalTo: rightAnchor),
            expandButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            expandButton.heightAnchor.constraint(equalToConstant: CompanyFooterView.shrinkHeight)
            ])
        
        linkButton.setTitle("홈페이지", for: .normal)
        addSubview(linkButton)
        linkButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            linkButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            linkButton.rightAnchor.constraint(equalTo: rightAnchor),
            linkButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10)
            ])

    }
    
    // MARK: UI
    
    private var viewHeightAnchor: NSLayoutConstraint?
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.preferredFont(forTextStyle: .caption1)
        view.numberOfLines = 2
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.preferredFont(forTextStyle: .caption2)
        view.numberOfLines = 0
        view.textColor = .gray
        return view
    }()

    private lazy var expandButton: UIButton = {
        let view = UIButton()
        view.addTarget(self, action: #selector(didTapExpandButton), for: .touchUpInside)
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var linkButton: UIButton = {
        let view = UIButton()
        view.addTarget(self, action: #selector(didTapLinkButton), for: .touchUpInside)
        return view
    }()
    
    // MARK: Event
    
    @objc
    private func didTapExpandButton(_ sender: UIButton) {
        delegate?.didTapExpandButton(self)
    }
    
    @objc
    private func didTapLinkButton(_ sender: UIButton) {
        let url = URL(string: "https://naver.com")!
        UIApplication.shared.open(url)
    }
}
