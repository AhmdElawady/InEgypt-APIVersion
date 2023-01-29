//
//  ProfileController.swift
//  InEgypt
//
//  Created by Awady on 4/4/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import UIKit

class MenuController: UITableViewController {
    
    var menuItems: [[String]] = [[]]
    var menuSectionItems: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        localizeItems()
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .backgroundColor
        tableView.register(ProfileCell.self, forCellReuseIdentifier: "ProfileCell")
    }
    
    private func localizeItems() {
        let appVersion = getVersion()
        let menuitems: [[String]] = [["Search", "Cities"], ["Language","About InEgypt"], [appVersion]]
        let menuHeaderTitles: [String] = ["InEgypt", "", ""]
        menuItems = menuitems.map { $0.map { $0.localized } }
        menuSectionItems = menuHeaderTitles.map { $0.localized }
    }
    
    private func getVersion() -> String {
        let infoDictionaryKey = Bundle.main.infoDictionary!
        let currentVersion = infoDictionaryKey["CFBundleShortVersionString"] as! String
//        let buildNumber = infoDictionaryKey["CFBundleVersion"] as! String
        return "Version No.".localized + " " + "\(currentVersion)"
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return menuSectionItems.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        menuSectionItems[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as? ProfileCell else { return UITableViewCell() }
        cell.titleLabel.text = menuItems[indexPath.section][indexPath.row]
        if indexPath.section == 2 {
            cell.titleLabel.textColor = .gray
            cell.backgroundColor = .backgroundColor
            cell.isUserInteractionEnabled = false
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        35
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0 where indexPath.row == 0:
            let destinationController = SearchController()
            navigationController?.pushViewController(destinationController, animated: true)
        case 0 where indexPath.row == 1:
            let citiesController = CitiesController()
            navigationController?.pushViewController(citiesController, animated: true)
        case 1 where indexPath.row == 0:
            changeLanguage()
        case 1 where indexPath.row == 1:
            let aboutUsController = AboutUsController()
            navigationController?.pushViewController(aboutUsController, animated: true)
        default: break
        }
    }
    
    private func changeLanguage() {
        LocalizationManager.shared.setLanguage(language: LocalizationManager.shared.getLanguage() == .arabic ? .english : .arabic)
    }
}

class ProfileCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .blackToWhite
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .backgroundColor
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
