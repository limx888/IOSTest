//
//  ViewControllerCollectionView.swift
//  Lmx
//  给UICollectionView添加头部视图headerView  通过设置组头的方式进行添加
//  Created by Lmx on 2020/12/3.
//  Copyright © 2020 Lmx. All rights reserved.
//

import UIKit

class ViewControllerCollectionView: UIViewController {
    
    fileprivate var collectionView: UICollectionView!
    fileprivate let headerViewId = "headerViewId"
    fileprivate let cellId = "CDCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        
        //1.设置头部视图size
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        
        //2.注册头部视图
        collectionView.register(CDCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerViewId)
        
        //注册单元格
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
}

extension ViewControllerCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //    func numberOfSections(in collectionView: UICollectionView) -> Int {
    //        return 3
    //    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = UIColor.yellow
        return cell
    }
    
    //3.添加header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerViewId, for: indexPath) as! CDCollectionHeader
            header.label.text = "我是header"
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 150)
    }
    
}
