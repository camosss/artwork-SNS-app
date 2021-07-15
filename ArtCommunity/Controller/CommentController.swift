//
//  CommentController.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/15.
//

import UIKit

private let reuseIdentifier = "CommentCell"
private let headerIdentifier = "CommentHeader"

class CommentController: UICollectionViewController {
    
    // MARK: - Properties
    
    // 댓글 다는 창
    private lazy var commentInputView: CommentInputAccesoryView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        
        let cv = CommentInputAccesoryView(frame: frame)
        cv.delegate = self
        return cv
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override var inputAccessoryView: UIView? {
        get { return commentInputView }
    }
    
    // 키보드를 숨기고 표시하는 기능 제공
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // 메인탭을 사라지게 하고 CommentInputAccesoryView띄우기
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        navigationItem.title = "댓글"
        
        // drag할 때 키보드 창이 내려가도록
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
        
        collectionView.backgroundColor = .white
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(CommentHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    }
    
}

// MARK: - UICollectionViewDataSource

extension CommentController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CommentCell
        
        return cell
    }
    
    // header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! CommentHeader
        return header
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CommentController: UICollectionViewDelegateFlowLayout {
    // 댓글 창 높이
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    
    // top에서 height만큼 밑으로
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
}

// MARK: - CommentInputAccesoryViewDelegate

extension CommentController: CommentInputAccesoryViewDelegate {
    
    func inputView(_ inputView: CommentInputAccesoryView, uploadComment comment: String) {
        inputView.clearCommentTextView()
    }
}
