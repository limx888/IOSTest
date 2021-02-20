//
//  ViewControllerCollectionView1.swift
//  Lmx
//  给UICollectionView添加头部视图headerView  通过contentInset设置
//  Created by Lmx on 2020/12/3.
//  Copyright © 2020 Lmx. All rights reserved.
//

import UIKit

class ViewControllerCollectionView1: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        
        collectionView.contentInset = UIEdgeInsets(top: 300, left: 0, bottom: 0, right: 0)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        
        let head = UIView(frame: CGRect(x: 0, y: -300, width: collectionView.frame.width, height: 300))
        collectionView.addSubview(head)
        head.isUserInteractionEnabled = true
        head.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        head.backgroundColor = UIColor.red
    }
    
    @objc func tap(){
        print("tap")
    }
    
}

extension ViewControllerCollectionView1: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = UIColor.yellow
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
}
