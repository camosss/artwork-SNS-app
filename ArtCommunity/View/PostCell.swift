//
//  PostCell.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/01.
//

import UIKit

class PostCell: UICollectionViewCell {
    
    // MARK: - Properties
    
//    private lazy var profileImageView: UIImageView = {
//        let iv = UIImageView()
//        iv.contentMode = .scaleAspectFill
//        iv.clipsToBounds = true
//        iv.isUserInteractionEnabled = true
//        iv.backgroundColor = .lightGray
//        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(showUserProfile))
//        iv.isUserInteractionEnabled = true
//        iv.addGestureRecognizer(tap)
//        
//        return iv
//    }()
//    
//    private lazy var usernameButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitleColor(.black, for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
//        button.addTarget(self, action: #selector(showUserProfile), for: .touchUpInside)
//        return button
//    }()
//    
//    private let postImageView: UIImageView = {
//        let iv = UIImageView()
//        iv.contentMode = .scaleAspectFill
//        iv.clipsToBounds = true
//        iv.isUserInteractionEnabled = true
//        iv.image = #imageLiteral(resourceName: "venom-7")
//        return iv
//    }()
//    
//    lazy var likeButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
//        button.tintColor = .black
//        button.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
//        return button
//    }()
//    
//    private lazy var commentButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
//        button.tintColor = .black
//        button.addTarget(self, action: #selector(didTapComments), for: .touchUpInside)
//        return button
//    }()
//    
//    private let likesLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.boldSystemFont(ofSize: 13)
//        return label
//    }()
//    
//    private let captionLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.numberOfLines = 3
//        return label
//    }()
//    
//    private let postTimeLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.boldSystemFont(ofSize: 12)
//        label.textColor = .lightGray
//        return label
//    }()
//    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    
    
}
