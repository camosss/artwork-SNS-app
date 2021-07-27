//
//  FeedHeader.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/17.
//

import UIKit

protocol FeedHeaderDelegate: AnyObject {
    func didSelect(filter: FeedFilterOptions)
}

class FeedHeader: UICollectionReusableView {

    // MARK: - Properties
    
    weak var delegate: FeedHeaderDelegate?
    
    private let filterBar = FeedFilterView()
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHeader()
        filterBar.delegate = self
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

// MARK: - FeedFilterViewDelegate

extension FeedHeader: FeedFilterViewDelegate {
    func filterView(_ view: FeedFilterView, didSelect index: Int) {
        
        guard let filter = FeedFilterOptions(rawValue: index) else { return }
        delegate?.didSelect(filter: filter)
    }
}
