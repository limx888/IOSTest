//
//  ProfileViewController.swift
//  Lmx
//
//  Created by Lmx on 2019/4/4.
//  Copyright © 2019 Lmx. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var portfolioImageView: UIImageView!
    @IBOutlet weak var protfolioLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
}
extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonalPhoto", for: indexPath) as! ProfileCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.height, height: collectionView.frame.size.height)
    }
}
