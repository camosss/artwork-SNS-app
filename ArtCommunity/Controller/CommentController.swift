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
    
    private var post: Post
    private var comments = [Comment]()
    
    // 댓글 다는 창
    private lazy var commentInputView: CommentInputAccesoryView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        
        let cv = CommentInputAccesoryView(frame: frame)
        cv.delegate = self
        return cv
    }()
    
    
    // MARK: - Lifecycle
    
    init(post: Post) {
        self.post = post
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchComments()
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
    
    // MARK: - API
    
    func fetchComments() {
        CommentService.fetchComments(forPost: post.postId) { comments in
            self.comments = comments
            self.collectionView.reloadData()
        }
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
        return comments.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CommentCell
        
        cell.delegate = self
        cell.viewModel = CommentViewModel(comment: comments[indexPath.row])
        return cell
    }
    
    // header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! CommentHeader
        
        header.viewModel = PostViewModel(post: post)
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
        
        guard let tab = tabBarController as? MainTapController else { return }
        guard let currentUser = tab.user else { return }
                
        CommentService.uploadComment(comment: comment, postID: post.postId, user: currentUser) { error in
            inputView.clearCommentTextView()
        }
        
        NotificationService.uploadNotification(toUid: post.ownerUid,
                                               fromUser: currentUser, type: .comment, post: post)
    }
}

// MARK: - CommentCellDelegate

extension CommentController: CommentCellDelegate {
    func cell(_ cell: CommentCell, goProfile uid: String) {
        
        UserService.fetchUser(withUid: uid) { user in
            let controller = ProfileController(user: user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
