//
//  PostCell.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/01.
//

import UIKit

class PostCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var viewModel: PostViewModel? {
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
        button.setTitle("Username", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.addTarget(self, action: #selector(GoProfile), for: .touchUpInside)
        return button
    }()

    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "venom-7")
        return iv
    }()

    lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        return button
    }()

    private let likesLabel: UILabel = {
        let label = UILabel()
        label.text = "0 좋아요"
        label.backgroundColor = .systemOrange
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()

    private let commentsLabel: UILabel = {
        let label = UILabel()
        label.text = "0 댓글"
        label.backgroundColor = .systemOrange
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()

    private let captionLabel: UILabel = {
        let label = UILabel()
        label.text = "작품명"
        label.backgroundColor = .systemOrange
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 3
        return label
    }()

    private let contentsLabel: UILabel = {
        let label = UILabel()
        label.text = "작품 소개"
        label.backgroundColor = .systemOrange
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 5
        return label
    }()

    private let postTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "0 분전"
        label.backgroundColor = .systemOrange
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
        print("DEUBG: go profile")
    }

    @objc func didTapLike() {
        print("DEBUG: tap like")
    }

    @objc func didTapComments() {
        print("DEBUG: tap comments")
    }

    // MARK: - Helpers
    
    func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
        postImageView.sd_setImage(with: viewModel.imageUrl)
        
        likesLabel.text = viewModel.likesLabelText
        likeButton.tintColor = viewModel.likeButtonTintColor
        likeButton.setImage(viewModel.likeButtonImage, for: .normal)
        
        captionLabel.text = viewModel.caption
        contentsLabel.text = viewModel.contents
        
        commentsLabel.text = viewModel.comments
        postTimeLabel.text = viewModel.timestampString
        
        profileImageView.sd_setImage(with: viewModel.userProfileImageUrl)
        usernameButton.setTitle(viewModel.username, for: .normal)
    }

    func configureUI() {
        backgroundColor = .systemPurple

        addSubview(postImageView)
        postImageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
        // 이미지 높이 조정
        postImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
     
        
        addSubview(likesLabel)
        likesLabel.anchor(top: postImageView.bottomAnchor, left: leftAnchor, right: rightAnchor,
                          paddingTop: 15, paddingLeft: 10, paddingRight: 300)
        
        addSubview(captionLabel)
        captionLabel.anchor(top: likesLabel.bottomAnchor, left: leftAnchor, right: rightAnchor,
                            paddingTop: 15, paddingLeft: 10, paddingRight: 10)
        
        addSubview(contentsLabel)
        contentsLabel.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, right: rightAnchor,
                             paddingTop: 15, paddingLeft: 10, paddingRight: 10, height: 80)
        
        
        let textStack = UIStackView(arrangedSubviews: [commentsLabel, postTimeLabel])
        textStack.axis = .vertical
        textStack.spacing = 10
        
        addSubview(textStack)
        textStack.anchor(top: contentsLabel.bottomAnchor, left: leftAnchor, right: rightAnchor,
                         paddingTop: 15, paddingLeft: 10, paddingRight: 300)
        
        
        let profileStack = UIStackView(arrangedSubviews: [profileImageView, usernameButton])
        profileStack.axis = .horizontal
        profileStack.spacing = 15
        
        addSubview(profileStack)
        profileStack.anchor(top: textStack.bottomAnchor, left: leftAnchor, paddingTop: 15, paddingLeft: 10)
        profileImageView.setDimensions(width: 60, height: 60)
        profileImageView.layer.cornerRadius = 60 / 2
        
        
        addSubview(likeButton)
        likeButton.anchor(top: postImageView.bottomAnchor, left: likesLabel.rightAnchor, right: rightAnchor,
                          paddingTop: 8, paddingLeft: 230, paddingRight: 20, height: 30)
    }
}
