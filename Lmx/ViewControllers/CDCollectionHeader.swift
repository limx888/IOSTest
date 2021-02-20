//
//  CDCollectionHeader.swift
//  Lmx
//
//  Created by Lmx on 2020/12/3.
//  Copyright © 2020 Lmx. All rights reserved.
//

import UIKit

class CDCollectionHeader: UICollectionReusableView {
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.red
        addSubview(label)
        label.textColor = UIColor.black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
