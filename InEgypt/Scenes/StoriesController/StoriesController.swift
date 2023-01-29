//
//  StunningController.swift
//  InEgypt
//
//  Created by Awady on 11/24/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class StoriesController: BaseCollectionViewController {
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Dismiss", for: .normal)
        button.addTarget(StoriesController.self, action: #selector(dismissPressed), for: .touchUpInside)
        return button
    }()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let stories = [
        Story.init(category: "Golden Tomb", title: "Tut Ankh Amun", image: #imageLiteral(resourceName: "Tut"), description: "The little golden king The little golden king, The little golden king, The little golden king, The little golden king", backgroundColor: .white),
        Story.init(category: "Pyramid", title: "Khufo", image: #imageLiteral(resourceName: "Khufu"), description: "The little golden king The little golden king, The little golden king, The little golden king, The little golden king", backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        view.addSubview(dismissButton)
        dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        dismissButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
//        dismissButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        collectionView.backgroundColor = #colorLiteral(red: 0.9489166141, green: 0.9490789771, blue: 0.9489063621, alpha: 1)
//        collectionView.contentInsetAdjustmentBehavior = .never
//        navigationController?.isNavigationBarHidden = true
        
    }
    
    @objc private func dismissPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func registerCell() {
        collectionView.register(StoryCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.tintColor = .white
//        UIApplication.shared.statusBarUIView?.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
//        navigationController?.navigationBar.backgroundColor = nil
//        UIApplication.shared.statusBarUIView?.isHidden = false
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return stories.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! StoryCell
        cell.storyItem = stories[indexPath.item]
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width-60, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 30, left: 0, bottom: 30, right: 0)
    }
    
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
        
    var detailesController: StoryDetailsController!
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailesController = StoryDetailsController()
        detailesController.storyItem = stories[indexPath.item]
        detailesController.dismissHandler = {
            self.handleCloseRedView()
        }
        let detailsView = detailesController.view!
        
        view.addSubview(detailsView)
        addChild(detailesController)
        
        self.detailesController = detailesController
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        
        self.startingFrame = startingFrame
        
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = detailsView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = detailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = detailsView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = detailsView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
        self.view.layoutIfNeeded()
//        redView.frame = startingFrame
//        detailsView.layer.cornerRadius = 16
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
//            redView.frame = self.view.frame
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            self.view.layoutIfNeeded()
            
//            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
        }, completion: {_ in
            self.navigationController?.navigationBar.isHidden = true
        })
    }
    
    var startingFrame: CGRect?
    
    @objc func handleCloseRedView() {
        self.navigationController?.navigationBar.isHidden = false
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.detailesController.tableView.scrollToRow(at: [0, 0], at: .top, animated: true)
            self.detailesController.tableView.contentOffset = .zero
            
//            self.detailesController.tableView.scrollRectToVisible(.zero, animated: true)
            
            guard let startingFrame = self.startingFrame else {return}
            self.topConstraint?.constant = startingFrame.origin.y
            self.leadingConstraint?.constant = startingFrame.origin.x
            self.widthConstraint?.constant = startingFrame.width
            self.heightConstraint?.constant = startingFrame.height
            self.view.layoutIfNeeded()
            self.tabBarController?.tabBar.transform = .identity
            self.detailesController.view!.layer.cornerRadius = 16
            
        }, completion: {_ in
            self.detailesController.view.removeFromSuperview()
//            gesture.view?.removeFromSuperview()
            self.detailesController.removeFromParent()
            
        })
    }
}
