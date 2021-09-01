//
//  HomeViewController.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 9/1/21.
//

import UIKit

class HomeViewController:UIViewController{
  
    
    
    // MARK: - Properties
    var myCollectionView: UICollectionView?
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIView()
        view.backgroundColor = .yellow
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        myCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        myCollectionView?.backgroundColor = .white
        
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
        
        view.addSubview(myCollectionView ?? UICollectionView())
        
        self.view = view
    }
}

extension HomeViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
        myCell.backgroundColor = .blue
        return myCell
    }
    
    
}

extension HomeViewController: UICollectionViewDelegate{
    
}
