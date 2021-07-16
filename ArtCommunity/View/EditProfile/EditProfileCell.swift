//
//  EditProfileCell.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/16.
//

import UIKit

class EditProfileCell: UITableViewCell {
    
    // MARK: - Properties
    
    var viewModel: EditProfileViewModel? {
        didSet { configureViewModel() }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var infoText: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textAlignment = .left
        tf.textColor = .black
        tf.addTarget(self, action: #selector(updataUserInfo), for: .editingDidEnd)
        return tf
    }()
    
    let bioTextView: InputBioTextView = {
        let tv = InputBioTextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.textColor = .black
        tv.placeholderLabel.text = "소개"
        return tv
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        configureViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    
    @objc func updataUserInfo() {
        
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        backgroundColor = .white
        
        selectionStyle = .none // 자동완성기능 off
        
        contentView.addSubview(titleLabel)
        titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        titleLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 16)
        
        contentView.addSubview(infoText)
        infoText.anchor(top: topAnchor, left: titleLabel.rightAnchor, bottom: bottomAnchor,
                             right: rightAnchor, paddingTop: 4, paddingLeft: 16, paddingRight: 8)
        
        contentView.addSubview(bioTextView)
        bioTextView.anchor(top: topAnchor, left: titleLabel.rightAnchor, bottom: bottomAnchor,
                           right: rightAnchor, paddingTop: 4, paddingLeft: 16, paddingRight: 8)
    }
    
    func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
        
    }
}
