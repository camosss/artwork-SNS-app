//
//  RegistrationController.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/06/27.
//

import UIKit
import Firebase

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    private var profileImage: UIImage?
    
    private let photoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(AddPhoto), for: .touchUpInside)
        return button
    }()
    
    private let nameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Name")
        return tf
    }()
    
    private lazy var nameContarinerView: UIView = {
        let image = #imageLiteral(resourceName: "profile_selected")
        let view = Utilities().inputContainerView(withImage: image, textField: nameTextField)
        return view
    }()
    
    private let majorTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Major")
        return tf
    }()
    
    private lazy var majorContarinerView: UIView = {
        let image = #imageLiteral(resourceName: "book")
        let view = Utilities().inputContainerView(withImage: image, textField: majorTextField)
        return view
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Email")
        return tf
    }()
    
    private lazy var emailContarinerView: UIView = {
        let image = #imageLiteral(resourceName: "email")
        let view = Utilities().inputContainerView(withImage: image, textField: emailTextField)
        return view
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var passwordContarinerView: UIView = {
        let image = #imageLiteral(resourceName: "password")
        let view = Utilities().inputContainerView(withImage: image, textField: passwordTextField)
        return view
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("이미 계정이 있으신가요?", for: .normal)
        button.addTarget(self, action: #selector(backLogin), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Action
    
    @objc func AddPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func handleSignUp() {
        guard let profileImage = profileImage else { return }
        guard let name = nameTextField.text else { return }
        guard let major = majorTextField.text?.lowercased() else { return }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        let credentials = AuthCredentials(profileImage: profileImage, name: name, major: major,
                                          email: email, password: password)
        
        AuthService.registerUser(withCredential: credentials) { error in
            if let error = error {
                print("DEBUG: RegistrationController -\(error.localizedDescription)")
                return
            }
            print("DEBUG: 회원가입 성공")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func backLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(photoButton)
        photoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 50)
        photoButton.setDimensions(width: 150, height: 150)
        
        let stack = UIStackView(arrangedSubviews: [nameContarinerView, majorContarinerView, emailContarinerView, passwordContarinerView, signUpButton, alreadyHaveAccountButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: photoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,
                     paddingTop: 50 ,paddingLeft: 16, paddingRight: 16)
        
    }
}

// MARK: - UIImagePickerControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        profileImage = selectedImage
        
        photoButton.layer.cornerRadius = photoButton.frame.width / 2
        photoButton.layer.masksToBounds = true
        photoButton.imageView?.contentMode = .scaleAspectFill
        photoButton.imageView?.clipsToBounds = true
        photoButton.layer.borderColor = UIColor.white.cgColor
        photoButton.layer.borderWidth = 3
        
        photoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
    }
}
