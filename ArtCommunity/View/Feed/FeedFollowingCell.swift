//
//  FeedFollowingCell.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/28.
//

import UIKit

protocol FeedFollowingCellDelegate: AnyObject {
    func cell(_ cell: FeedFollowingCell, goProfile uid: String)
}

class FeedFollowingCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    weak var delegate: FeedFollowingCellDelegate?
    
    var viewModel: PostViewModel? {
        didSet { configure() }
    }
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = .lightGray
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(goProfile))
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(tap)
        
        return iv
    }()
    
    private lazy var usernameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(goProfile), for: .touchUpInside)
        return button
    }()
    
    private lazy var postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
        
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    
    @objc func goProfile() {
        guard let viewModel = viewModel else { return }
        delegate?.cell(self, goProfile: viewModel.post.ownerUid)
    }
    
    // MARK: - Helpers

    func configureCell() {
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingLeft: 12)
        profileImageView.setDimensions(width: 40, height: 40)
        profileImageView.layer.cornerRadius = 40/2
        
        addSubview(usernameButton)
        usernameButton.centerY(inView: profileImageView,
                      leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        
        addSubview(postImageView)
        postImageView.anchor(top: profileImageView.bottomAnchor, left: leftAnchor,
                             right: rightAnchor, paddingTop: 8, paddingLeft: 15, paddingRight: 15)
        postImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        
    }

    func configure() {
        guard let viewModel = viewModel else { return }
        
        profileImageView.sd_setImage(with: viewModel.userProfileImageUrl)
        usernameButton.setTitle(viewModel.username, for: .normal)
        postImageView.sd_setImage(with: viewModel.imageUrl)
    }

}


