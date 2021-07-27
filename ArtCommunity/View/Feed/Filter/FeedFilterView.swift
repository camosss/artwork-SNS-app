//
//  FeedFilterView.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/27.
//

import UIKit

private let reuseIdentifier = "FeedFilterCell"

protocol FeedFilterViewDelegate: AnyObject {
    func filterView(_ view: FeedFilterView, didSelect index: Int)
}

class FeedFilterView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: FeedFilterViewDelegate?
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    private let underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        collectionView.register(FeedFilterCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        addSubview(collectionView)
        collectionView.addConstraintsToFillView(self)
        
        // 처음 Home으로 자동 선택
        let selectedFirst = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: selectedFirst, animated: true, scrollPosition: .left)
    }
    
    // 실제 프레임에 접근하기 위해 layoutSubview에 넣는다
    override func layoutSubviews() {
        addSubview(underLineView)
        underLineView.anchor(left: leftAnchor, bottom: bottomAnchor, width: frame.width / 2, height: 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource

extension FeedFilterView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FeedFilterOptions.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedFilterCell
        
        let option = FeedFilterOptions(rawValue: indexPath.row)
        cell.option = option
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension FeedFilterView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        // 해당 indexPath(경로)에 대한 cell을 얻는다
        let cell = collectionView.cellForItem(at: indexPath)
        
        // xPosition을 얻은 다음 밑줄이 그어진 뷰를 해당 x의 위치로 animate
        let xPosition = cell?.frame.origin.x ?? 0
        UIView.animate(withDuration: 0.2) { self.underLineView.frame.origin.x = xPosition }
        
        delegate?.filterView(self, didSelect: indexPath.row)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedFilterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 2, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
