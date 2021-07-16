//
//  CommentHeader.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/15.
//

import UIKit

class CommentHeader: UICollectionReusableView {

    // MARK: - Properties
    
    var viewModel: PostViewModel? {
        didSet { configureViewModel() }
    }
    
    private lazy var postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.borderColor = UIColor.white.cgColor
        return iv
    }()
    
    private let postCaptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
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
    
    // MARK: - Helpers
    
    func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
        postImageView.sd_setImage(with: viewModel.imageUrl)
        postCaptionLabel.text = viewModel.caption
        contentLabel.text = viewModel.contents
        postTimeLabel.text = viewModel.timestampString
    }
    
    func configureUI() {
        
        addSubview(postImageView)
        postImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 10)
        postImageView.setDimensions(width: 60, height: 60)
        
        let stack = UIStackView(arrangedSubviews: [postCaptionLabel, postTimeLabel])
        stack.axis = .horizontal
        stack.spacing = 8
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: postImageView.rightAnchor,
                     paddingTop: 10, paddingLeft: 17)
        
        addSubview(contentLabel)
        contentLabel.anchor(top: stack.bottomAnchor, left: postImageView.rightAnchor, right: rightAnchor,
                             paddingTop: 5, paddingLeft: 17, paddingRight: 10)
        contentLabel.numberOfLines = 0
        
        let divider = UIView()
        divider.backgroundColor = .lightGray
        
        addSubview(divider)
        divider.anchor(top: postImageView.bottomAnchor, left: leftAnchor, right: rightAnchor,
                       paddingTop: 15, paddingLeft: 10, paddingRight: 10, height: 0.5)
    }
    
}
