//
//  ChatCell.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/22.
//

import UIKit

class ChatCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private let textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = .systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textColor = .white
        tv.text = "test"
        return tv
    }()
    
    private let bubbleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 8, paddingBottom: -4)
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        
        addSubview(bubbleContainer)
        bubbleContainer.layer.cornerRadius = 12
        bubbleContainer.anchor(top: topAnchor, left: profileImageView.rightAnchor, paddingLeft: 12)
        bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        bubbleContainer.addSubview(textView)
        textView.anchor(top: bubbleContainer.topAnchor, left: bubbleContainer.leftAnchor,
                        bottom: bubbleContainer.bottomAnchor, right: bubbleContainer.rightAnchor,
                        paddingTop: 4, paddingLeft: 12, paddingBottom: 4, paddingRight: 12)
    }
}

