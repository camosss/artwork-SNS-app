//
//  EditProfileController.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/16.
//

import UIKit

private let reuseIdentifier = "EditProfileCell"

protocol EditProfileControllerDelegate: AnyObject {
    func controller(_ controller: EditProfileController, updateInfo user: User)
}

class EditProfileController: UITableViewController {
    
    // MARK: - Properties
    
    weak var delegate: EditProfileControllerDelegate?
    
    private var user: User
    
    private lazy var headerView = EditProfileHeader(user: user)
    
    private let imagePicker = UIImagePickerController()
    
    private var userInfoChanged = false
    
    // 프사 변경
    private var selectedImage: UIImage? {
        didSet { headerView.profileImageView.image = selectedImage }
    }
    
    // 선택한 이미지에 값이 있으면 변경되었음을 의미
    private var imageChanged: Bool { return selectedImage != nil }
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(style: .plain) // .plain -> 테이블 뷰 스크롤
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
        configureImagePicker()
        
    }
    
    // MARK: - Action
    
    @objc func TapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func TapDone() {
        // 끝나면 편집 종료
        view.endEditing(true)
        
        // 2개 중 하나만 입력되어도 Done 활성화
        guard imageChanged || userInfoChanged else { return }
        updateUserData()
    }
    
    // MARK: - API
    
    func updateUserData() {
        
        // 프사가 변경 O, 유저정보가 변경 X
        if imageChanged && !userInfoChanged {
            updateProfileImage()
        }
        
        // 프사가 변경 X, 유저정보가 변경 O
        if !imageChanged && userInfoChanged {
            UserService.saveUserData(user: user) { error in
                self.delegate?.controller(self, updateInfo: self.user)
            }
        }
        
        // 프사가 변경 O, 유저정보가 변경 O
        if imageChanged && userInfoChanged {
            UserService.saveUserData(user: user) { error in
                self.updateProfileImage()
            }
        }
        
    }
    
    func updateProfileImage() {
        guard let image = selectedImage else { return }
        
        UserService.updateProfileImage(image: image) { profileImageUrl in
            
            var profileImage = URL(string: self.user.profileImageUrl)
            profileImage = profileImageUrl
            
            // 사용자 업데이트
            self.delegate?.controller(self, updateInfo: self.user)
        }
    }
    
    
    // MARK: - Helpers
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = false // 반투명 제거
        navigationController?.navigationBar.tintColor = .systemBlue // bar button item
        
        navigationItem.title = "Edit Profile"

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_arrow_back_white_24dp"), style: .plain, target: self, action: #selector(TapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(TapDone))
    }
    
    func configureTableView() {
        tableView.tableHeaderView = headerView
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 180)
        headerView.delegate = self
        
        tableView.tableFooterView = UIView()
        tableView.register(EditProfileCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        // drag할 때 키보드 창이 내려가도록
        tableView.alwaysBounceVertical = true
        tableView.keyboardDismissMode = .interactive
    }
    
    func configureImagePicker() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
    
}

// MARK: - UITableViewDataSource

extension EditProfileController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EditProfileOptions.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EditProfileCell
        
        guard let option = EditProfileOptions(rawValue: indexPath.row) else { return cell }
        cell.viewModel = EditProfileViewModel(user: user, option: option)
        cell.delegate = self
        return cell
    }
    
    // 각 옵션 높이 지정
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let option = EditProfileOptions(rawValue: indexPath.row) else { return 0 }
        return option == .bio ? 100 : 48
    }
}

// MARK: - EditProfileHeaderDelegate

extension EditProfileController: EditProfileHeaderDelegate {
    func didTapChangeProfilePhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension EditProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        self.selectedImage = image
        
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - EditProfileCellDelegate

extension EditProfileController: EditProfileCellDelegate {
    func updateUserInfo(_ cell: EditProfileCell) {
        guard let viewModel = cell.viewModel else { return }
        
        userInfoChanged = true
        navigationItem.rightBarButtonItem?.isEnabled = true // done 활성화
        
        switch viewModel.option {
        case .name:
            guard let name = cell.infoText.text else { return }
            user.name = name
        case .major:
            guard let major = cell.infoText.text else { return }
            user.major = major
        case .bio:
            user.bio = cell.bioTextView.text
        }
    }
}
