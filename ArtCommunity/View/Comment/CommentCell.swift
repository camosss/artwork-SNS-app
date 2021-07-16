//
//  CommentCell.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/15.
//

import UIKit

class CommentCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var viewModel: CommentViewModel? {
        didSet { configureViewModel() }
    }
    
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
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(GoProfile), for: .touchUpInside)
        return button
    }()
    
    private let commentLabel = UILabel()
    
    private let postTimeLabel: UILabel = {
        let label = UILabel()
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
        print("profile")
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
                     paddingTop: 10, paddingLeft: 10)
        
        addSubview(commentLabel)
        commentLabel.anchor(top: stack.bottomAnchor, left: profileImageView.rightAnchor, right: rightAnchor,
                            paddingTop: 2, paddingLeft: 10, paddingRight: 10)
        commentLabel.numberOfLines = 0
    }
    
    func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        commentLabel.text = viewModel.commentText
        usernameButton.setTitle(viewModel.username, for: .normal)
        postTimeLabel.text = viewModel.timestampString
    }
}
