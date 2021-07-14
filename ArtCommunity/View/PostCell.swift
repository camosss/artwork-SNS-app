//
//  PostCell.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/01.
//

import UIKit

protocol PostCellDelegate: AnyObject {
    func cell(_ cell: PostCell, goProfile uid: String)
    func cell(_ cell: PostCell, didLike post: Post)
    func cell(_ cell: PostCell, showComment post: Post)
}

class PostCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    weak var delegate: PostCellDelegate?
    
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
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(GoProfile), for: .touchUpInside)
        return button
    }()

    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()

    lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        return button
    }()

    private let likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()

    private lazy var commentsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(didTapComments))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(labelTap)
        
        return label
    }()

    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 3
        return label
    }()

    private let contentsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 5
        return label
    }()

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
        guard let viewModel = viewModel else { return }
        delegate?.cell(self, goProfile: viewModel.post.ownerUid)
    }

    @objc func didTapLike() {
        guard let viewModel = viewModel else { return }
        delegate?.cell(self, didLike: viewModel.post)
    }

    @objc func didTapComments() {
        guard let viewModel = viewModel else { return }
        delegate?.cell(self, showComment: viewModel.post)
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
        backgroundColor = .white
        

        addSubview(postImageView)
        postImageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
        // 이미지 높이 조정
        postImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
     
        
        addSubview(captionLabel)
        captionLabel.anchor(top: postImageView.bottomAnchor, left: leftAnchor, right: rightAnchor,
                            paddingTop: 15, paddingLeft: 10, paddingRight: 200)
        
        addSubview(contentsLabel)
        contentsLabel.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, right: rightAnchor,
                             paddingTop: 10, paddingLeft: 10, paddingRight: 10, height: 50)
        
        
        let textStack = UIStackView(arrangedSubviews: [commentsLabel, postTimeLabel])
        textStack.axis = .vertical
        textStack.spacing = 5
        
        addSubview(textStack)
        textStack.anchor(top: contentsLabel.bottomAnchor, left: leftAnchor, right: rightAnchor,
                         paddingTop: 5, paddingLeft: 10, paddingRight: 200)
        
        
        let profileStack = UIStackView(arrangedSubviews: [profileImageView, usernameButton])
        profileStack.axis = .horizontal
        profileStack.spacing = 15
        
        addSubview(profileStack)
        profileStack.anchor(top: textStack.bottomAnchor, left: leftAnchor, paddingTop: 13, paddingLeft: 10)
        profileImageView.setDimensions(width: 60, height: 60)
        profileImageView.layer.cornerRadius = 60 / 2
        
        
        addSubview(likeButton)
        likeButton.anchor(top: postImageView.bottomAnchor, left: captionLabel.rightAnchor, right: rightAnchor,
                          paddingTop: 15, paddingLeft: 125, paddingRight: 50)
        
        addSubview(likesLabel)
        likesLabel.anchor(top: postImageView.bottomAnchor, left: likeButton.rightAnchor, paddingTop: 10, paddingLeft: 1)
        
    }
}
