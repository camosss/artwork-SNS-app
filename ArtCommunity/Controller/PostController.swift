//
//  PostController.swift
//  ArtCommunity
//
//  Created by 강호성 on 2021/07/01.
//

import UIKit

private let reuseIdentifier = "PostCell"

class PostController: UICollectionViewController {
    
    // MARK: - Properties
   
    var post: Post? {
        didSet { self.collectionView.reloadData() }
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        collectionView.backgroundColor = .white
        
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
   
}

// MARK: - UICollectionViewDataSource

extension PostController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PostCell
        
        if let post = post {
            cell.viewModel = PostViewModel(post: post)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

// PostCell이 들어갈 크기

extension PostController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        let height = width + 270
        
        return CGSize(width: width, height: height)
    }
}
