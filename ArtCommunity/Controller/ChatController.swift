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
    }
    
    override var inputAccessoryView: UIView? {
        get { return chatInputView }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        navigationItem.title = user.name
        collectionView.backgroundColor = .white
        
        collectionView.register(ChatCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true // 수직
        
    }
}

// MARK: - UICollectionViewDataSource

extension ChatController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChatCell
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ChatController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
}

// MARK: - ChatInputAccesoryViewDelegate

extension ChatController: ChatInputAccesoryViewDelegate {
    func inputView(_ inputView: ChatInputAccesoryView, wantsToSend message: String) {
        
        // 메세지 보내기 후, 입력창에 text없애기
        inputView.chatTextView.text = nil
        
        fromCurrentUser.toggle()
        
        let message = Message(text: message, isFromCurrentUser: fromCurrentUser)
        messages.append(message)
        collectionView.reloadData()
        
    }
}
