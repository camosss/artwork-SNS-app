//
//  FeedCell.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/17.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var viewModel: PostViewModel? {
        didSet { configure() }
    }
    
    private lazy var postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureCell() {
        backgroundColor = .white
        
        addSubview(postImageView)
        postImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingBottom: 30)
        postImageView.setDimensions(width: 60, height: 100)
        postImageView.layer.cornerRadius = 40 / 2
        
        addSubview(captionLabel)
        captionLabel.anchor(top: postImageView.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 10)
        
    }
    
    func configure() {
        guard let viewModel = viewModel else { return }
        
        postImageView.sd_setImage(with: viewModel.imageUrl)
        captionLabel.text = viewModel.caption
    }

}
