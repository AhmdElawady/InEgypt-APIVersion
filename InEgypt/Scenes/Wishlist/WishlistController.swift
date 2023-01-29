//
//  WishlistController.swift
//  InEgypt
//
//  Created by Awady on 9/15/22.
//  Copyright © 2022 AwadyStore. All rights reserved.
//

import UIKit

private let reuseIdentifier = "WishlistCell"

class WishlistController: UICollectionViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(WishlistCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        
    
        return cell
    }

    // MARK: UICollectionViewDelegate

  

}
