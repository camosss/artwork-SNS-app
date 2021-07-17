//
//  FeedHeader.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/17.
//

import UIKit

class FeedHeader: UICollectionReusableView {


    // MARK: - Properties
    
    private let adImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "KakaoTalk_Photo_2021-06-22-23-48-13")
        return iv
    }()
    
    private let filterBar = FilterView()
    
    
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
        backgroundColor = .systemTeal
        
        addSubview(adImageView)
        adImageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
        adImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        addSubview(filterBar)
        filterBar.anchor(top: adImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, height: 50)
    }

}
