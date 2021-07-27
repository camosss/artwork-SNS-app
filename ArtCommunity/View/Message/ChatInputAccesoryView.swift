//
//  ChatInputAccesoryView.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/22.
//

import UIKit

protocol ChatInputAccesoryViewDelegate: AnyObject {
    func inputView(_ inputView: ChatInputAccesoryView, wantsToSend message: String)
}

class ChatInputAccesoryView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: ChatInputAccesoryViewDelegate?
    
    private lazy var chatTextView: InputTextView = {
        let tv = InputTextView()
        tv.placeholderText = "메세지 보내기.."
        tv.font = UIFont.systemFont(ofSize: 15)
        tv.isScrollEnabled = false
        return tv
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("보내기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // view 자체의 속성만 고려하여 받는 자연스러운 크기
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    // MARK: - Action
    
    @objc func sendMessage() {
        guard let message = chatTextView.text else { return }
        delegate?.inputView(self, wantsToSend: message)
    }
    
    // MARK: - Helpers
    
    // 메세지을 보내고 난 뒤, text 없애기
    func clearCommentTextView() {
        chatTextView.text = nil
        chatTextView.placeholderLabel.isHidden = false
    }
    
    func configureUI() {
        
        // message줄과 inputAccesoryView가 겹치지 않게
        backgroundColor = .white
        
        // 키보드를 열고 내리면서의 높이 변화
        // 장치의 화면에 따라 유연하게 변형
        autoresizingMask = .flexibleHeight
        
        addSubview(sendButton)
        sendButton.anchor(top: topAnchor, right: rightAnchor, paddingRight: 8)
        sendButton.setDimensions(width: 50, height: 50)
        
        addSubview(chatTextView)
        chatTextView.anchor(top: topAnchor, left: leftAnchor,
                               bottom: safeAreaLayoutGuide.bottomAnchor, right: sendButton.leftAnchor,
                               paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
        
        let divider = UIView()
        divider.backgroundColor = .lightGray
        
        addSubview(divider)
        divider.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
    }
    
    // 채팅 보낸 후에도 placeholderLabel이 뜨도록
    func clearMessageText() {
        chatTextView.text = nil
        chatTextView.placeholderLabel.isHidden = false
    }
}
