//
//  InputBioTextView.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/16.
//

import UIKit

class InputBioTextView: UITextView {
    
    // MARK: - Properties
    
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.text = "소개"
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        backgroundColor = .white
        font = UIFont.systemFont(ofSize: 16)
        isScrollEnabled = false
        heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 4)
        
        // Text에 입력했을때 "소개" 사라지고 Text입력
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange),
                                               name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func handleTextInputChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
}
