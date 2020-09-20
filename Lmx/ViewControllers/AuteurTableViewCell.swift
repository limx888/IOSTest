//
//  AuteurTableViewCell.swift
//  Lmx
//  xib和纯代码实现cell高度自适应
//  Created by Lmx on 2020/9/18.
//  Copyright © 2020 Lmx. All rights reserved.
//

import UIKit
import SnapKit

class AuteurTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bioLabel: UILabel!
    
    //使用xib方式创建cell，在dequeueReusableCell()时会调用到该方法
    //本例中使用的是xib方式
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    //懒加载label
    lazy var contentLable:UILabel = {()-> UILabel in
        
        let lable:UILabel = UILabel()
        lable.numberOfLines = 0
        lable.font = UIFont.systemFont(ofSize: 20)
        lable.isUserInteractionEnabled = true
        
        return lable
    }()
    
    //重写cell init方法
    //使用纯代码方式创建cell，在dequeueReusableCell()时会调用到该方法
    //需要在该方法中创建view
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
//        fatalError("init(coder:) has not been implemented")
    }
    
    // 初始化布局
    fileprivate func initLayout() {
        contentLable.snp.makeConstraints {(make) -> Void in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(0)
        }
        //重点：给contentView布局，让它的底部跟contentLable的底部一致
        contentView.snp.makeConstraints {(make) -> Void in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(contentLable.snp.bottom).offset(10)
        }
    }
    
    // 初始化页面布局
    func initView(){
        contentLable.numberOfLines = 0
        contentLable.isUserInteractionEnabled = true
        contentView.addSubview(contentLable)
        
        initLayout()
    }
    
    // 初始化数据并重设文本高度
    func initData(content: String) {
        contentLable.text = content
        var height:CGFloat = 0
        if !content.isEmpty && content != "" {
            // 高度计算
            height = contentLable.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height)).height
        }
        // 更新cell高度
        contentLable.snp.updateConstraints {(make) -> Void in
            make.height.equalTo(height)
        }
        
    }
}
