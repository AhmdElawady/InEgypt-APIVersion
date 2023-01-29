//
//  TripsController.swift
//  InEgypt
//
//  Created by Awady on 4/1/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

//import UIKit
//
//class TripsController: UITableViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupController()
//    }
//    
//    private func setupController() {
//        tableView.backgroundColor = .white
//        tableView.separatorStyle = .none
//        navigationItem.largeTitleDisplayMode = .always
//        navigationItem.backBarButtonItem = UIBarButtonItem(title:"".localized, style:.plain, target:nil, action:nil)
//        tableView.register(CreateTripCell.self, forCellReuseIdentifier: "CreateTripCell")
//    }
//
//    // MARK: - Table view data source
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreateTripCell", for: indexPath) as? CreateTripCell else { return UITableViewCell() }
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return tableView.frame.height * 0.35
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let tripRequestController = TripRequestController()
//        self.navigationController?.pushViewController(tripRequestController, animated: true)
//    }
//}
