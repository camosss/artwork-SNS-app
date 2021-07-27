//
//  FeedHeader.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/17.
//

import UIKit

class FeedHeader: UICollectionReusableView {


    // MARK: - Properties
    
    private let filterBar = FeedFilterView()
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers

    func configureHeader() {
        backgroundColor = .white
        
        addSubview(filterBar)
        filterBar.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor,
                         paddingLeft: 80, paddingRight: 80, height: 50)
    }

}
