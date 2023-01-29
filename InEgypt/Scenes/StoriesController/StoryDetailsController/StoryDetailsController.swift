//
//  StunningDetailsController.swift
//  InEgypt
//
//  Created by Awady on 11/25/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

class StoryDetailsController: UITableViewController {
    
    var storyItem: Story?
    var dismissHandler: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        tableView.register(StoryDetailsCell.self, forCellReuseIdentifier: "StoryDetailsCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.tintColor = .white
        UIApplication.shared.statusBarUIView?.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.backgroundColor = nil
        UIApplication.shared.statusBarUIView?.isHidden = false
    }
    
    // MARK: - Table view data source
    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = StunningCell()
//        return header
//    }
//
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        450
//    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let headerCell = StoryDetailsHeaderCell()
            headerCell.closeButton.addTarget(self, action: #selector(closePressed), for: .touchUpInside)
            headerCell.storyCell.storyItem = storyItem
            return headerCell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryDetailsCell", for: indexPath) as? StoryDetailsCell else { return UITableViewCell() }
        
//        let cell = StoryDetailsCell()
        return cell
    }
    
    @objc fileprivate func closePressed(button: UIButton) {
        button.isHidden = true
        dismissHandler?()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 450
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
}
