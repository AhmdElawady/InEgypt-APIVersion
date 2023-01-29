//
//  ImageZoomingController.swift
//  InEgypt
//
//  Created by Awady on 12/29/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

class ImageZoomingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    init() { super.init(collectionViewLayout: UICollectionViewFlowLayout()) }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        let btnImage = UIImage(systemName: "xmark")
        let tintedImage = btnImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(dismissPressed), for: .touchUpInside)
        return button
    }()
    
    var selectedIndexPath: Int = 1
    var images: [ImageData] = []
    var viewTranslation = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        addDismissButton()
        view.backgroundColor = .black
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDragDismiss)))
    }
    
    private func setupCollectionView() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        collectionView.showsHorizontalScrollIndicator = false
        self.collectionView!.register(ImageZoomingCell.self, forCellWithReuseIdentifier: "ImageZoomingCell")
    }
    
    private func addDismissButton() {
        view.addSubview(dismissButton)
        dismissButton.anchor(top: view.topAnchor, right: view.rightAnchor, topConstant: 60, rightConstant: 30, widthConstant: 30, heightConstant: 30)
    }
    
    @objc private func dismissPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleDragDismiss(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            viewTranslation = sender.translation(in: collectionView)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.collectionView.backgroundColor = .clear
                let offset =  1 - abs(self.viewTranslation.y / 300)
                self.view.backgroundColor = UIColor.black.withAlphaComponent(offset)
                self.dismissButton.alpha = 0
                self.collectionView.transform = CGAffineTransform(translationX: self.viewTranslation.x, y: self.viewTranslation.y)
            })
            
        case .ended:
            if viewTranslation.y < 200 && viewTranslation.y > -200 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.collectionView.transform = .identity
                    self.view.backgroundColor = .black
                    self.dismissButton.alpha = 1
                })
            } else {
                let transition: CATransition = CATransition()
                transition.duration = 0.5
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
                transition.type = CATransitionType.fade
                self.collectionView.window!.layer.add(transition, forKey: nil)
                dismiss(animated: false, completion: nil)
            }
        default:
            break
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageZoomingCell", for: indexPath) as! ImageZoomingCell
        cell.displayImage(data: images[indexPath.item].image)
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    var onceOnly = false
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
      if !onceOnly {
        let indexToScrollTo = IndexPath(item: selectedIndexPath, section: 0)
        self.collectionView.scrollToItem(at: indexToScrollTo, at: .left, animated: false)
        onceOnly = true
      }
    }
}
