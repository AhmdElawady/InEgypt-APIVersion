//
//  TripRequestController.swift
//  InEgypt
//
//  Created by Awady on 4/1/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

//import UIKit
////import MaterialComponents.MaterialTextControls_FilledTextFields
////import MaterialComponents.MaterialTextControls_FilledTextAreas
//
//class TripRequestController: UIViewController, UISearchBarDelegate {
//
//    let selectedPlacesCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        layout.scrollDirection = .horizontal
//        collectionView.backgroundColor = .backgroundColor
//        collectionView.isScrollEnabled = true
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        }
//        return collectionView
//    }()
//
//    // user info
//    let userInfoLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .subTitleGray
//        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
//        label.text = "Contact Information".localized
//        return label
//    }()
//
//    let userInfoContainer: UIView = {
//        let view = UIView()
//        view.backgroundColor = .backgroundColor
//        view.layer.cornerRadius = 10
//        return view
//    }()
//
////    let nameTextField: UITextField = {
//////        let textField = MDCFilledTextField()
////        textField.label.text = "Your Name".localized
////        textField.placeholder = "Enter your name".localized
//////        textField.customeTextField()
////        return textField
////    }()
////
////    let phoneNumTextField: MDCFilledTextField = {
////        let textField = MDCFilledTextField()
////        textField.keyboardType = .phonePad
////        textField.label.text = "Phone Number".localized
////        textField.placeholder = "555-555-5555"
//////        textField.customeTextField()
////        return textField
////    }()
//
//    // Trip info
//    let tripInfoLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .subTitleGray
//        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
//        label.text = "Trip Information".localized
//        return label
//    }()
//
//    let addTripInfoButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Send Request".localized, for: .normal)
//        button.tintColor = .whiteToBlack
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
//        button.backgroundColor = .appBlue
//        button.layer.cornerRadius = 5
//        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        button.addTarget(TripRequestController.self, action: #selector(sendRequestPressed), for: .touchUpInside)
//        return button
//    }()
//
//    let placesSearchBar: UISearchBar = {
//        let searchBar = UISearchBar()
//        searchBar.searchBarStyle = .minimal
//        searchBar.placeholder = "Add Destinations".localized
//        return searchBar
//    }()
//
//    let tripInfoContainer: UIView = {
//        let view = UIView()
//        view.backgroundColor = .backgroundColor
//        view.layer.cornerRadius = 10
//        return view
//    }()
//
//    let adultStepper: UIStepper = {
//        let stepper = UIStepper()
//        stepper.minimumValue = 0
//        stepper.maximumValue = 20
//        stepper.wraps = false
//        stepper.autorepeat = true
//        stepper.addTarget(TripRequestController.self, action: #selector(adultStepperPressed), for: .valueChanged)
//        return stepper
//    }()
//
//    let adultTitleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Adults ".localized
//        label.textColor = .subTitleGray
//        return label
//    }()
//
//    let adultLabelCount: UILabel = {
//        let label = UILabel()
//        label.text = "0"
//        label.textColor = .valueTextColor
//        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
//        return label
//    }()
//
//    let childStepper: UIStepper = {
//        let stepper = UIStepper()
//        stepper.minimumValue = 0
//        stepper.maximumValue = 20
//        stepper.wraps = false
//        stepper.autorepeat = true
//        stepper.addTarget(TripRequestController.self, action: #selector(childStepperPressed), for: .valueChanged)
//        return stepper
//    }()
//
//    let childTitleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Childs ".localized
//        label.textColor = .subTitleGray
//        return label
//    }()
//
//    let childLabelCount: UILabel = {
//        let label = UILabel()
//        label.text = "0"
//        label.textColor = .valueTextColor
//        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
//        return label
//    }()
//
//    let roomStepper: UIStepper = {
//        let stepper = UIStepper()
//        stepper.minimumValue = 0
//        stepper.maximumValue = 20
//        stepper.wraps = false
//        stepper.autorepeat = true
//        stepper.addTarget(TripRequestController.self, action: #selector(roomStepperPressed), for: .valueChanged)
//        return stepper
//    }()
//
//    let roomTitleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Rooms ".localized
//        label.textColor = .subTitleGray
//        return label
//    }()
//
//    let roomLabelCount: UILabel = {
//        let label = UILabel()
//        label.text = "0"
//        label.textColor = .valueTextColor
//        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
//        return label
//    }()
//
//    let budgetStepper: UIStepper = {
//        let stepper = UIStepper()
//        stepper.minimumValue = 500
//        stepper.maximumValue = 10000
//        stepper.wraps = false
//        stepper.autorepeat = true
//        stepper.stepValue = 250
//        stepper.addTarget(TripRequestController.self, action: #selector(budgetStepperPressed), for: .valueChanged)
////        stepper.layer.borderWidth = 1
////        stepper.layer.borderColor = UIColor.green.cgColor
////        stepper.layer.cornerRadius = 5
//
//        return stepper
//    }()
//
//    let budgetTitleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Budget(person) ".localized
//        label.textColor = .subTitleGray
//        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
//        return label
//    }()
//
//    let budgetLabelCount: UILabel = {
//        let label = UILabel()
//        label.text = "000"
//        label.textColor = .valueTextColor
//        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
//        return label
//    }()
//
//    // Note
////    let noteTextField: MDCFilledTextArea = {
////        let textField = MDCFilledTextArea()
////        textField.contentVerticalAlignment = .top
////        textField.backgroundColor = .backgroundColor
////        textField.setNormalLabel(.darkGray, for: .normal)
////        textField.setFloatingLabel(.subTitleGray, for: .editing)
////        textField.setFloatingLabel(.subTitleGray, for: .normal)
////        textField.setFilledBackgroundColor(.backgroundColor, for: .normal)
////        textField.setFilledBackgroundColor(.whiteToBlack, for: .editing)
////        textField.setUnderlineColor(.clear, for: .normal)
////        textField.setUnderlineColor(.clear, for: .editing)
////        textField.label.text = "More Preferences".localized
////        textField.setTextColor(.valueTextColor, for: .normal)
////        textField.placeholder = "Near to Nile river, Soft all inclusive...".localized
////        textField.layer.cornerRadius = 10
////        textField.anchor(heightConstant: 150)
////        textField.clipsToBounds = true
////        return textField
////    }()
//
//    lazy var RequestButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Send Request".localized, for: .normal)
//        button.tintColor = .whiteToBlack
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
//        button.backgroundColor = .appBlue
//        button.layer.cornerRadius = 5
//        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        button.addTarget(self, action: #selector(sendRequestPressed), for: .touchUpInside)
//        return button
//    }()
//
//    let placesTitleTableView: UITableView = {
//        let tableView = UITableView()
//        tableView.backgroundColor = .backgroundColor
//        return tableView
//    }()
//
//    let startDatePicker: UIDatePicker = {
//        let datePicker = UIDatePicker()
//        datePicker.datePickerMode = .date
//        if #available(iOS 13.4, *) {
//            datePicker.preferredDatePickerStyle = .compact
//        } else {
//            // Fallback on earlier versions
//        }
//        datePicker.backgroundColor = .backgroundColor
//        datePicker.translatesAutoresizingMaskIntoConstraints = false
//        return datePicker
//    }()
//
//    let endDatePicker: UIDatePicker = {
//        let datePicker = UIDatePicker()
//        datePicker.datePickerMode = .date
//        if #available(iOS 13.4, *) {
//            datePicker.preferredDatePickerStyle = .compact
//        } else {
//            // Fallback on earlier versions
//        }
//        datePicker.backgroundColor = .backgroundColor
//        datePicker.translatesAutoresizingMaskIntoConstraints = false
//        return datePicker
//    }()
//
//    let hotelDataLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .subTitleGray
//        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
//        label.text = "Hotel Preferences".localized
//        return label
//    }()
//
//    let hotelDataContainer: UIView = {
//        let view = UIView()
//        view.backgroundColor = .backgroundColor
//        view.layer.cornerRadius = 10
//        return view
//    }()
//
//    let beachTitleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Beach ".localized
//        label.textColor = .subTitleGray
//        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
//        return label
//    }()
//
//    let aquaParkTitleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Aqua Park ".localized
//        label.textColor = .subTitleGray
//        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
//        return label
//    }()
//
//    let starsTitleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Stars ".localized
//        label.textColor = .subTitleGray
//        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
//        return label
//    }()
//
//    let starRatingView: FloatRatingView = {
//        let ratingView = FloatRatingView()
//        ratingView.emptyImage = UIImage(systemName: "star")?.withTintColor(.subTitleGray, renderingMode: .alwaysOriginal)
//        ratingView.fullImage = UIImage(systemName: "star.fill")?.withTintColor(.appYellow, renderingMode: .alwaysOriginal)
//        ratingView.type = .wholeRatings
//        ratingView.minRating = 0
//        ratingView.maxRating = 5
//        ratingView.editable = true
//        ratingView.anchor(widthConstant: 140, heightConstant: 20)
//        return ratingView
//    }()
//
//    let beachSegmented = UISegmentedControl(items: ["Sandy", "Rocky", "Any"])
//    let aquaParkSegmented = UISegmentedControl(items: ["Yes", "Any"])
//
//    let scrollView: UIScrollView = {
//        let scrollView = UIScrollView(frame: .zero)
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.alwaysBounceVertical = true
//        scrollView.bounces = true
//        return scrollView
//    }()
//
//    var allPlacesData: [TripDestination] = []
//    var filteredPlacesData: [TripDestination] = []
//    var selectedData: [TripDestination] = []
//    var activeField: UITextField?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupNavigationBar()
//        setupController()
//        addSubviews()
//        fetchDestinations()
//    }
//
//    private func setupController() {
//        navigationItem.title = "Create A Trip".localized
//
//        self.activeField = UITextField()
//
//        placesSearchBar.delegate = self
//
//        placesTitleTableView.delegate = self
//        placesTitleTableView.dataSource = self
//
//        selectedPlacesCollectionView.delegate = self
//        selectedPlacesCollectionView.dataSource = self
//
//        selectedPlacesCollectionView.register(SelectedPlaceCell.self, forCellWithReuseIdentifier: "SelectedPlaceCell")
//        placesTitleTableView.register(SearchedForTripCell.self, forCellReuseIdentifier: "SearchedForTripCell")
//
////        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
////        view.addGestureRecognizer(tap)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
////    @objc private func dismissKeyboard() {
////        self.view.endEditing(true)
////    }
//
//    @objc private func keyboardWillShow(notification: Notification) {
//        guard let keyboardInfo = notification.userInfo else {return}
//        if let keyboardSize = (keyboardInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.origin {
//            let keyboardHeight = keyboardSize.y
//            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
//            self.scrollView.contentInset = contentInset
//            var viewRect = self.view.frame
//            viewRect.size.height -= keyboardHeight
//            guard let activeField = self.activeField else { return }
//            if (!viewRect.contains(activeField.frame.origin)) {
//                let scrollPoint = CGPoint(x: 0, y: activeField.frame.origin.y - keyboardHeight)
//                self.scrollView.setContentOffset(scrollPoint, animated: true)
//            }
//        }
//    }
//
//    @objc private func keyboardWillHide() {
//        let contentInsets = UIEdgeInsets.zero
//        self.scrollView.contentInset = contentInsets
//    }
//
//    private func addSubviews() {
//
//        let personNumsStack: UIStackView = {
//            let adultsStack = UIStackView(arrangedSubviews: [adultTitleLabel,  UIView(), adultLabelCount, adultStepper])
//            adultsStack.spacing = 20
//            let childStack = UIStackView(arrangedSubviews: [childTitleLabel,  UIView(), childLabelCount, childStepper])
//            childStack.spacing = 20
//            let stackView = UIStackView(arrangedSubviews: [adultsStack, childStack])
//            stackView.axis = .vertical
//            stackView.spacing = 2
//            stackView.distribution = .fillEqually
//            return stackView
//        }()
//
//        let dateStack: UIStackView = {
//            let fromLabel = UILabel()
//            fromLabel.textColor = .subTitleGray
//            fromLabel.text = "From ".localized
//            let toLabel = UILabel()
//            toLabel.textColor = .subTitleGray
//            toLabel.text = "To ".localized
//
//            let fromStack = UIStackView(arrangedSubviews: [fromLabel, startDatePicker])
//            let toStack = UIStackView(arrangedSubviews: [toLabel, endDatePicker])
//            let stackView = UIStackView(arrangedSubviews: [fromStack, UIView(), toStack])
//            stackView.axis = .horizontal
//
//            return stackView
//        }()
//
////        let userInfoStack: UIStackView = {
////            let stackView = UIStackView(arrangedSubviews: [nameTextField, phoneNumTextField])
////            stackView.axis = .vertical
////            stackView.spacing = 5
////
////            return stackView
////        }()
//
//        userInfoContainer.addSubview(userInfoStack)
//        userInfoStack.anchor(top: userInfoContainer.topAnchor, left: userInfoContainer.leftAnchor, bottom: userInfoContainer.bottomAnchor, right: userInfoContainer.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 10)
//
//        let userInfoStackContainer: UIStackView = {
//            let stackView = UIStackView(arrangedSubviews: [userInfoLabel, userInfoContainer])
//            stackView.spacing = 5
//            stackView.axis = .vertical
//            return stackView
//        }()
//
//        let placesStack: UIStackView = {
//            let roomStack = UIStackView(arrangedSubviews: [roomTitleLabel,  UIView(), roomLabelCount, roomStepper])
//            roomStack.spacing = 20
//            let placesStack = UIStackView(arrangedSubviews: [placesSearchBar, placesTitleTableView, selectedPlacesCollectionView])
//            let budgetStack = UIStackView(arrangedSubviews: [budgetTitleLabel, budgetLabelCount, budgetStepper])
//            budgetStack.spacing = 20
//            placesStack.axis = .vertical
//            placesStack.spacing = 2
//            let stackView = UIStackView(arrangedSubviews: [placesStack, personNumsStack, roomStack, dateStack, budgetStack])
//            stackView.axis = .vertical
//            stackView.spacing = 20
//
//            placesTitleTableView.anchor(heightConstant: view.frame.height * 0.33)
//            placesTitleTableView.isHidden = true
//            selectedData.count == 0 ? (selectedPlacesCollectionView.isHidden = true) : (selectedPlacesCollectionView.isHidden = false)
//
//            return stackView
//        }()
//
//        tripInfoContainer.addSubview(placesStack)
//        placesStack.anchor(top: tripInfoContainer.topAnchor, left: tripInfoContainer.leftAnchor, bottom: tripInfoContainer.bottomAnchor, right: tripInfoContainer.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 10)
//
//        let tripInfoContainerStack: UIStackView = {
//            let stackView = UIStackView(arrangedSubviews: [tripInfoLabel, tripInfoContainer])
//            stackView.axis = .vertical
//            stackView.spacing = 5
//            return stackView
//        }()
//
//        let beachStack: UIStackView = {
//            beachSegmented.selectedSegmentIndex = 0 // prevent unselected crash
//            let stackView = UIStackView(arrangedSubviews: [beachTitleLabel, UIView(), beachSegmented])
////            stackView.axis = .vertical
//            stackView.spacing = 10
//            return stackView
//        }()
//
//        let aquaParkStack: UIStackView = {
//            aquaParkSegmented.selectedSegmentIndex = 0 // prevent unselected crash
//            let stackView = UIStackView(arrangedSubviews: [aquaParkTitleLabel, UIView(), aquaParkSegmented])
////            stackView.axis = .vertical
//            stackView.spacing = 10
//            return stackView
//        }()
//
//        let hotelStarsStack: UIStackView = {
//            let label = UILabel()
//            label.text = "Stars".localized
//            label.font = UIFont.systemFont(ofSize: 14, weight: .light)
//            let stack = UIStackView(arrangedSubviews: [label, starRatingView])
//            stack.spacing = 80
//            return stack
//        }()
//
//        let hotelStack: UIStackView = {
//            let stackView = UIStackView(arrangedSubviews: [beachStack, aquaParkStack, hotelStarsStack])
//            stackView.axis = .vertical
//            stackView.spacing = 20
//            return stackView
//        }()
//
//        hotelDataContainer.addSubview(hotelStack)
//        hotelStack.anchor(top: hotelDataContainer.topAnchor, left: hotelDataContainer.leftAnchor, bottom: hotelDataContainer.bottomAnchor, right: hotelDataContainer.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 10)
//
//        let hotelDataContainerStack: UIStackView = {
//           let stackView = UIStackView(arrangedSubviews: [hotelDataLabel, hotelDataContainer])
//            stackView.axis = .vertical
//            stackView.spacing = 5
//            return stackView
//        }()
//
////        let containerStack: UIStackView = {
////            let stackView = UIStackView(arrangedSubviews: [tripInfoContainerStack, hotelDataContainerStack, noteTextField, userInfoStackContainer,  RequestButton])
////            stackView.axis = .vertical
////            stackView.spacing = 40
////
////            return stackView
////        }()
//
//        scrollView.addSubview(containerStack)
//        containerStack.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, topConstant: 30, leftConstant: 10, bottomConstant: 30, rightConstant: 10, widthConstant: view.frame.size.width - 20)
//
//        view.addSubview(scrollView)
//        scrollView.fillSuperview()
//    }
//
//    func fetchDestinations() {
//        CreateTripService.shared.fetchDestinations { results, error in
//            if error != nil { print("Trip Destination spots error") }
//            DispatchQueue.main.async {
//                self.allPlacesData = results?.data ?? []
//                self.filteredPlacesData = results?.data ?? []
//                self.placesTitleTableView.reloadData()
//            }
//        }
//    }
//
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        placesTitleTableView.isHidden = false
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        guard !searchText.isEmpty else {
//            filteredPlacesData = allPlacesData
//            placesTitleTableView.reloadData()
//            return
//        }
//
//        filteredPlacesData = allPlacesData.filter({ (place) -> Bool in
//                                                    place.name.lowercased().contains(searchText.lowercased())})
//        placesTitleTableView.reloadData()
//    }
//
//    @objc private func adultStepperPressed(_ sender: UIStepper) {
//        adultLabelCount.text = "\(Int(sender.value))"
//    }
//
//    @objc private func childStepperPressed(_ sender: UIStepper) {
//        childLabelCount.text = "\(Int(sender.value))"
//    }
//
//    @objc private func roomStepperPressed(_ sender: UIStepper) {
//        roomLabelCount.text = "\(Int(sender.value))"
//    }
//
//    @objc private func budgetStepperPressed(_ sender: UIStepper) {
//        budgetLabelCount.text = "\(Int(sender.value))"
//    }
//
//
//    @objc private func sendRequestPressed() {
//        guard nameTextField.text != "", phoneNumTextField.text != "" else {
//            BaseAlert.show(title: "Username and Phone number required".localized, message: "Fill your preferable info so we can check availability", vc: self, handler: nil)
//            return
//        }
//        uploadRequest()
//    }
//
//    private func uploadRequest() {
//        let token = UIDevice.current.identifierForVendor?.uuidString
//
//        let selectedPlacesids = selectedData.map { $0.id }
//        let selectedPlacesTitles = selectedData.map { $0.name }
//
//        let adults = adultLabelCount.text
//        let childs = childLabelCount.text
//        let rooms = roomLabelCount.text
//        let fromDate = "\(startDatePicker.date)"
//        let toDate = "\(endDatePicker.date)"
//        let budget = budgetLabelCount.text
//
//        let selectedBeach = beachSegmented.titleForSegment(at: beachSegmented.selectedSegmentIndex) ?? ""
//        let selectedAquaPark = aquaParkSegmented.titleForSegment(at: aquaParkSegmented.selectedSegmentIndex) ?? ""
//        let hotelRate = "\(starRatingView.rating)"
//
//        let morePreferences = noteTextField.textView.text
//        let username = nameTextField.text
//        let userphone = phoneNumTextField.text
//
//        let requestBody = TripRequestBody(
//            destination: selectedPlacesids,
//            destination_name: selectedPlacesTitles,
//            username: username ?? "",
//            phone: userphone ?? "",
//            token: token ?? "",
//            adults: adults ?? "",
//            childs: childs ?? "",
//            room: rooms,
//            from_date: fromDate,
//            to_date: toDate,
//            budget: budget,
//            preferences: morePreferences,
//            beach: selectedBeach,
//            aquaPark: selectedAquaPark,
//            stars: hotelRate)
//
//        CreateTripService.shared.postATripRequest(body: requestBody) { response, error in
//            if error != nil { print("Destination spots error") }
//            DispatchQueue.main.async {
//                if response?.status == 200 {
//                    BaseAlert.show(title: "Done".localized, message: "We will contact you withen 24 hours".localized, vc: self) { action in
//                        self.navigationController?.popViewController(animated: true)
//                    }
//                } else if response?.status == 404 {
//                    BaseAlert.show(title: "Repeated!".localized, message: "You already have a comment there".localized, vc: self) { action in
//                        self.navigationController?.popViewController(animated: true)
//                    }
//                }
//            }
//        }
//    }
//}
//
//extension TripRequestController: UITextFieldDelegate, UITextViewDelegate {
//    override func viewWillAppear(_ animated: Bool) {
//        nameTextField.delegate = self
//        phoneNumTextField.delegate = self
//        noteTextField.textView.delegate = self
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        self.activeField = nil
//        return true
//    }
//
//    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
//        textView.resignFirstResponder()
//        return true
//    }
//}
//
//extension TripRequestController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        selectedData.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedPlaceCell", for: indexPath) as? SelectedPlaceCell else { return UICollectionViewCell() }
//        cell.titleLabel.text = selectedData[indexPath.item].name
//        selectedData.count == 0 ? (collectionView.isHidden = true) : (collectionView.isHidden = false)
//        cell.closeButton.tag = indexPath.row
//        cell.closeButton.addTarget(self, action: #selector(deleteAndCloesCell), for: .touchUpInside)
//        return cell
//    }
//    @objc private func deleteAndCloesCell(sender: UIButton) {
//        let index = sender.tag
//        selectedData.remove(at: index)
//        selectedPlacesCollectionView.reloadData()
//        if selectedData.count == 0 {selectedPlacesCollectionView.isHidden = true}
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let item = selectedData[indexPath.row]
//        let itemSize = item.name.size(withAttributes: nil)
//
//        return CGSize(width: itemSize.width + 50, height: 30)
//    }
//}
//
//extension TripRequestController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        filteredPlacesData.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchedForTripCell", for: indexPath) as? SearchedForTripCell else { return UITableViewCell() }
//        cell.titleLabel.text = filteredPlacesData[indexPath.row].name
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        35
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedData.append(filteredPlacesData[indexPath.row])
//        selectedPlacesCollectionView.isHidden = false
//        selectedPlacesCollectionView.reloadData()
//        placesSearchBar.endEditing(true)
//        placesTitleTableView.isHidden = true
//        let collectionIndexPath = IndexPath(row: selectedData.count-1, section: 0)
//        selectedPlacesCollectionView.scrollToItem(at: collectionIndexPath, at: .right, animated: true)
//    }
//}


