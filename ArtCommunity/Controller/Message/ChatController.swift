//
//  ChatController.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/22.
//

import UIKit

private let reuseIdentifier = "ChatCell"

class ChatController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let user: User
    private var messages = [Message]()
    var fromCurrentUser = false
        
    private lazy var chatInputView: ChatInputAccesoryView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        
        let cv = ChatInputAccesoryView(frame: frame)
        cv.delegate = self
        return cv
    }()
    
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchMessages()
    }
    
    override var inputAccessoryView: UIView? {
        get { return chatInputView }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - API
    
    func fetchMessages() {
        MessageService.fetchMessages(forUser: user) { messages in
            self.messages = messages
            self.collectionView.reloadData()
            self.keyboardNotifications()

            // 메세지를 가져올 때마다 collectionView를 맨 아래로 스크롤
            self.collectionView.scrollToItem(at: [0, self.messages.count - 1],
                                             at: .bottom, animated: true)
        }
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        navigationItem.title = user.name
        collectionView.backgroundColor = .white
        
        collectionView.register(ChatCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true // 수직
        collectionView.keyboardDismissMode = .interactive
    }
    
    func keyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboard(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboard(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Action
        
    @objc func handleKeyboard(_ noti: NSNotification) {
        
            UIView.animate(withDuration: 0, delay: 0) {
                self.view.layoutIfNeeded()
            } completion: { completion in
                self.collectionView.scrollToItem(at: [0, self.messages.count - 1],
                                                 at: .bottom, animated: true)
            }
    }
}

// MARK: - UICollectionViewDataSource

extension ChatController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChatCell
        
        cell.message = messages[indexPath.row]
        cell.message?.user = user
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ChatController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 장문의 채팅 cell사이즈 조정
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let estimateSizeCell = ChatCell(frame: frame) // 예상크기의 cell 생성
        estimateSizeCell.message = messages[indexPath.row]
        estimateSizeCell.layoutIfNeeded() // 높이가 50보다 작거나 같으면 필요 X
        
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedSize = estimateSizeCell.systemLayoutSizeFitting(targetSize) // 최적으로 만족하는 뷰의 크기 반환
        
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 30, right: 0)
    }
}

// MARK: - ChatInputAccesoryViewDelegate

extension ChatController: ChatInputAccesoryViewDelegate {
    func inputView(_ inputView: ChatInputAccesoryView, wantsToSend message: String) {
        
        MessageService.uploadMessage(message, to: user) { error in
            if let error = error {
                print("DEBUG: Failed to upload message with error \(error.localizedDescription)")
                return
            }
            
            // 메세지 보내기 후, 입력창에 text없애기
            inputView.clearMessageText()
        }
    }
}
