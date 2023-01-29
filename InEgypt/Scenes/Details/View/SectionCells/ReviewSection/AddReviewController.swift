//
//  AddReviewController.swift
//  InEgypt
//
//  Created by Awady on 1/4/21.
//  Copyright © 2021 AwadyStore. All rights reserved.
//

import UIKit

protocol AddReviewDelegate {
    func reloadReviews()
}

class AddReviewController: UIViewController {
    
    var addReviewDelegate: AddReviewDelegate!
    
    let posterContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        return view
    }()
    
    let addReviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Add a Review".localized
        label.textColor = .blackToWhite
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel".localized, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.tintColor = .appBlue
        button.addTarget(self, action: #selector(dismissPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var sendButton: LoadingUIButton = {
        let button = LoadingUIButton(type: .system)
        button.setTitle("Send".localized, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.tintColor = .appBlue
        button.addTarget(self, action: #selector(sendPressed), for: .touchUpInside)
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .nightViewColor
        return label
    }()
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.layer.cornerRadius = 3
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let tapAStarLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap a Star to Rate".localized
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .subTitleGray
        return label
    }()
    
    let ratingView: FloatRatingView = {
        let ratingView = FloatRatingView()
        ratingView.emptyImage = UIImage(systemName: "star")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        ratingView.fullImage = UIImage(systemName: "star.fill")?.withTintColor(.appBlue, renderingMode: .alwaysOriginal)
        ratingView.type = .wholeRatings
        ratingView.minRating = 0
        ratingView.maxRating = 5
        ratingView.editable = true
        ratingView.anchor(widthConstant: 155, heightConstant: 22)
        return ratingView
    }()
    
    let yourNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:".localized
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .subTitleGray
        return label
    }()
    
    let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.textColor = .valueTextColor
        textField.textAlignment = .natural
        return textField
    }()
    
    let reviewTextView: UITextView = {
        let textV = UITextView()
        textV.font = UIFont.systemFont(ofSize: 15)
        textV.textColor = .valueTextColor
        textV.backgroundColor = .backgroundColor
        return textV
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    let separatorView2: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    let reviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Review:".localized
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .subTitleGray
        return label
    }()
    
    var id = Int()
    let scrollView = UIScrollView(frame: .zero)
    var activeField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        userNameTextField.delegate = self
        reviewTextView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        addSubViews()
    }
    
    @objc private func keyboardWillHide() {
        let contentInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInsets
    }
    
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    private func addSubViews() {
        let topStackView = UIStackView(arrangedSubviews: [dismissButton, addReviewLabel, sendButton])
        topStackView.distribution = .equalSpacing
        
        posterContainerView.addSubview(posterImageView)
        posterImageView.fillSuperview()
        
        posterContainerView.addSubview(titleLabel)
        titleLabel.fillSuperview()
        
        let addRateStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [ratingView, tapAStarLabel])
            stack.axis = .vertical
            stack.alignment = .center
            stack.spacing = 5
            return stack
        }()
        
        let addNameStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [yourNameLabel, userNameTextField])
            userNameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
            stack.axis = .vertical
            return stack
        }()
        
        let addReviewStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [reviewLabel, reviewTextView])
            stack.axis = .vertical
            return stack
        }()
        
        posterContainerView.anchor(heightConstant: 150)
        reviewTextView.anchor(heightConstant: 130)
        
        let vStack: UIStackView = {
            let stack = UIStackView(arrangedSubviews: [topStackView, posterContainerView, addRateStack, separatorView, addNameStack, separatorView2, addReviewStack])
            stack.axis = .vertical
            stack.spacing = 10
            return stack
        }()
        
        let deviceType = UIDevice.current.deviceSize
        let widthInset: CGFloat = deviceType == .iPad ? 137 : 20
        scrollView.addSubview(vStack)
        vStack.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, topConstant: 30, leftConstant: 10, bottomConstant: 30, rightConstant: 10, widthConstant: view.frame.width - widthInset)
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        
        
        if LocalizationManager.shared.getLanguage() == .arabic {
            userNameTextField.textAlignment = .right
            reviewTextView.textAlignment = .right
        } else {
            userNameTextField.textAlignment = .left
            reviewTextView.textAlignment = .left
        }
    }
    
    @objc private func dismissPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    private func closeViewController() {
        dismiss(animated: true) { [self] in
            if addReviewDelegate != nil { addReviewDelegate.reloadReviews() }
        }
    }
    
    @objc private func sendPressed() {
        sendButton.showLoading()
        guard !ratingView.rating.isZero else {
            Alert.show(title: "Rate at least 1 Star".localized, message: "", vc: self, handler: nil)
            sendButton.hideLoading()
            return
        }
        guard userNameTextField.text != "" else {
            Alert.show(title: "Your Name Required".localized, message: "", vc: self, handler: nil)
            sendButton.hideLoading()
            return
        }
        guard reviewTextView.text != "" else {
            Alert.show(title: "Give A Comment Please".localized, message: "", vc: self, handler: nil)
            sendButton.hideLoading()
            return
        }
        uploadReview()
    }
    
    func uploadReview() {
        let body = ReviewBody(id: id, username: userNameTextField.text ?? "", rate: Int(ratingView.rating), review: reviewTextView.text ?? "")
        
        DetailsInteractor.shared.postAReview(body: body) { response, error in
            if error != nil { print("Details add review error") }
            DispatchQueue.main.async { [self] in
                if response?.status == 200 {
                    Banner.basicBannerView(title: "", message: "Review added successfully".localized, iconText: "")
                    Alert.show(title: "Done".localized, message: "Thanks for reviewing :)".localized, vc: self) { [self] action in
                        closeViewController()
                        sendButton.hideLoading()
                    }
                } else if response?.status == 404 {
                    Alert.show(title: "Repeated!".localized, message: "You already have a comment there".localized, vc: self) { [self] action in
                        closeViewController()
                        sendButton.hideLoading()
                    }
                }
            }
        }
    }
    
    func displayImage(data: String) {
        ImageService.downloadImage(withData: data, imageView: posterImageView)
    }
}



extension AddReviewController: UITextFieldDelegate, UITextViewDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        userNameTextField.delegate = self
        reviewTextView.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 20
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let maxLength = 600
        let currentString: NSString = (textView.text ?? "") as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: text) as NSString
        return newString.length <= maxLength
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.activeField = nil
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
}
