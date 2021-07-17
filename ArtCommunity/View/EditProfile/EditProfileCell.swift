//
//  EditProfileCell.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/16.
//

import UIKit

protocol EditProfileCellDelegate: AnyObject {
    func updateUserInfo(_ cell: EditProfileCell)
}

class EditProfileCell: UITableViewCell {
    
    // MARK: - Properties
    
    weak var delegate: EditProfileCellDelegate?
    
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
        delegate?.updateUserInfo(self)
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
                           right: rightAnchor, paddingTop: 4, paddingLeft: 14, paddingRight: 8)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updataUserInfo),
                                               name: UITextView.textDidEndEditingNotification, object: nil)
    }
    
    func configureViewModel() {
        guard let viewModel = viewModel else { return }
        
        infoText.isHidden = viewModel.shouldHideTextField
        bioTextView.isHidden = viewModel.shouldHideTextView
        
        titleLabel.text = viewModel.titleText
        infoText.text = viewModel.optionValue
        bioTextView.text = viewModel.optionValue

        bioTextView.placeholderLabel.isHidden = viewModel.shouldHidePlacholderLabel
    }
}
