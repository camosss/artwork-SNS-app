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
    
    private let underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
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
        
        addSubview(underLineView)
        underLineView.anchor(left: leftAnchor, bottom: bottomAnchor, width: frame.width / 2, height: 2)
    }
}

// MARK: - FeedFilterViewDelegate

extension FeedHeader: FeedFilterViewDelegate {
    func filterView(_ view: FeedFilterView, didSelect indexPath: IndexPath) {
        
        // 해당 indexPath(경로)에 대한 cell을 얻는다
        guard let cell = view.collectionView.cellForItem(at: indexPath) as? FeedFilterCell else { return }
        
        // xPosition을 얻은 다음 밑줄이 그어진 뷰를 해당 x의 위치로 animate
        let xPosition = cell.frame.origin.x * 1.65
        UIView.animate(withDuration: 0.2) { self.underLineView.frame.origin.x = xPosition }
    }
}
