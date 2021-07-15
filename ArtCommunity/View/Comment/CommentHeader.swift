//
//  CommentHeader.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/15.
//

import UIKit

class CommentHeader: UICollectionReusableView {

    // MARK: - Properties
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.borderColor = UIColor.white.cgColor
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(GoProfile))
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(tap)
        
        return iv
    }()
    
    private lazy var usernameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("post username", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(GoProfile), for: .touchUpInside)
        return button
    }()
    
    private let postCaptionLabel: UILabel = {
        let label = UILabel()
        
        let attributedString = NSMutableAttributedString(string: "post caption", attributes: [.font: UIFont.systemFont(ofSize: 14)])
        label.attributedText = attributedString
        return label
    }()
    
    private let postTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "10분전"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .lightGray
        return label
    }()
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    
    @objc func GoProfile() {
        print("DEBUG: post 올린 사용자 프로필")
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        
        addSubview(profileImageView)
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 8)
        profileImageView.setDimensions(width: 40, height: 40)
        profileImageView.layer.cornerRadius = 40 / 2
        
        let stack = UIStackView(arrangedSubviews: [usernameButton, postTimeLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: profileImageView.rightAnchor,
                     paddingTop: 8, paddingLeft: 10)
        
        addSubview(postCaptionLabel)
        postCaptionLabel.anchor(top: stack.bottomAnchor, left: profileImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 2, paddingLeft: 10, paddingBottom: 3, paddingRight: 10)
        postCaptionLabel.numberOfLines = 0
        
        let divider = UIView()
        divider.backgroundColor = .lightGray
        
        addSubview(divider)
        divider.anchor(top: postCaptionLabel.bottomAnchor, left: leftAnchor, right: rightAnchor,
                       paddingTop: 10, height: 0.5)
    }
    
}
