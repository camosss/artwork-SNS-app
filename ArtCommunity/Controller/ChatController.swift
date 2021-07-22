//
//  ChatController.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/22.
//

import UIKit

class ChatController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let user: User
    
    private lazy var chatInputView: ChatInputAccesoryView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        
        let cv = ChatInputAccesoryView(frame: frame)
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
        collectionView.backgroundColor = .white
        navigationItem.title = user.name
    }
}
