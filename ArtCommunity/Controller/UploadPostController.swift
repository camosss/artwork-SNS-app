//
//  UploadPostController.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/06/30.
//

import UIKit
import JGProgressHUD

protocol UploadPostControllerDelegate: AnyObject {
    func controllerDidFinishUploadingPost(_ controller: UploadPostController)
}

class UploadPostController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: UploadPostControllerDelegate?
    
    var currentUser: User?
    
    var selectedImage: UIImage? {
        didSet { photoImageView.image = selectedImage }
    }
    
    private let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.text = "작품명"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var captionTextView: InputTextView = {
        let tv = InputTextView()
        tv.placeholderText = "작품명을 입력해주세요"
        tv.font = UIFont.systemFont(ofSize: 18)
        tv.delegate = self
        return tv
    }()
    
    private let contentsLabel: UILabel = {
        let label = UILabel()
        label.text = "작품 소개"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var contentsTextView: InputTextView = {
        let tv = InputTextView()
        tv.placeholderText = "작품을 소개해주세요"
        tv.font = UIFont.systemFont(ofSize: 18)
        tv.delegate = self
        return tv
    }()
    
    private let characterCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Action
    
    @objc func TapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func TapDone() {
        guard let image = selectedImage else { return }
        guard let caption = captionTextView.text else { return }
        guard let contents = contentsTextView.text else { return }
        guard let user = currentUser else { return }
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "업로드"
        hud.show(in: view)
        
        PostService.uploadPost(caption: caption, contents: contents, image: image, user: user) { error in
            if let error = error {
                print(error.localizedDescription)
                hud.dismiss()
                return
            }
            hud.dismiss()
            self.delegate?.controllerDidFinishUploadingPost(self)
        }
    }
    
    // MARK: - Helpers
    
    func checkMaxLength(_ textView: UITextView) {
        if (textView.text.count) > 100 {
            textView.deleteBackward()
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "새 게시물"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(TapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(TapDone))
        
        view.addSubview(photoImageView)
        photoImageView.setDimensions(width: 180, height: 180)
        photoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        photoImageView.centerX(inView: view)
        photoImageView.layer.cornerRadius = 10
       
        view.addSubview(captionLabel)
        captionLabel.anchor(top: photoImageView.bottomAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 12)
        
        view.addSubview(captionTextView)
        captionTextView.anchor(top: captionLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 12, paddingRight: 12, height: 64)
        
        view.addSubview(contentsLabel)
        contentsLabel.anchor(top: captionTextView.bottomAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 12)

        view.addSubview(contentsTextView)
        contentsTextView.anchor(top: contentsLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                                paddingTop: 16, paddingLeft: 12, height: 64)

        view.addSubview(characterCountLabel)
        characterCountLabel.anchor(bottom: contentsTextView.bottomAnchor, right: view.rightAnchor, paddingBottom: -8, paddingRight: 12)
    }
}

// MARK: - UITextViewDelegate

extension UploadPostController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView)
        let count = textView.text.count
        characterCountLabel.text = "\(count)/100"
    }
}
