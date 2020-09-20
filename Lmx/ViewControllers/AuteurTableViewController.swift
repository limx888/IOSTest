//
//  AuteurTableViewController.swift
//  Lmx
//  两种方式注册实现tableview自适应高度
//  Created by Lmx on 2020/9/18.
//  Copyright © 2020 Lmx. All rights reserved.
//

import UIKit

class AuteurTableViewController: UITableViewController {

    let cellIdentifier = "AuteurTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        //两种register方式：
        //通过UINib注册，适用于xib方式，本例中，cell采用的是xib方式而非纯代码。
        let nib = UINib.init(nibName: "AuteurTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)

        // 通过class注册，适用于纯代码方式，需要在cell文件中重写init(style: UITableViewCellStyle, reuseIdentifier: String?)在其中初始化view
        tableView.register(AuteurTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AuteurTableViewCell

        var content: String = ""
        if indexPath.row % 2 == 0 {
            content = "11223131231231312dddddddddddddddddddfa31312312313"
        } else {
            content = "1122313123123131231ddddddddddddsadfasdfasdfasfasdfddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd312312313"
        }
        
        // 通过UINib注册，适用于xib方式，初始化数据
        if cell.bioLabel != nil {
            cell.bioLabel.text = content
        }
        
        // 通过class注册，初始化数据
        cell.initData(content: content)
        
        return cell
    }
}
