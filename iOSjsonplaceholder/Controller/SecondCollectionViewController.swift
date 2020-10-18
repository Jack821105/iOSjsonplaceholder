//
//  SecondCollectionViewController.swift
//  iOSjsonplaceholder
//
//  Created by 許自翔 on 2020/9/24.
//

import UIKit

private let reuseIdentifier = "Cell"

class SecondCollectionViewController: UICollectionViewController {
    
    
    var jsonPlaceholderlist = [JSONPlaceholder]()
    
    var photo: JSONPlaceholder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        //控制cell
        let itemSpace: CGFloat = 0
        let columnCount: CGFloat = 4
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let width = floor((collectionView.bounds.width  - itemSpace * (columnCount)) / columnCount)
        print("width",width, collectionView.bounds)
        flowLayout?.itemSize = CGSize(width: width, height: width)
        flowLayout?.estimatedItemSize = .zero
        flowLayout?.minimumInteritemSpacing = itemSpace
        flowLayout?.minimumLineSpacing = itemSpace
        flowLayout?.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        NetworkController.shared.getAllProduct { (i :[JSONPlaceholder]) in
            if i != nil{
                self.jsonPlaceholderlist = i
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return jsonPlaceholderlist.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(SecondCollectionViewCell.self)", for: indexPath) as? SecondCollectionViewCell
       
        cell?.jsonP = jsonPlaceholderlist[indexPath.item]
       /*畫面呈現*/
        cell?.update()
        
        if let cell = cell {
            return cell
        }else{
            return UICollectionViewCell()
        }
        
    }
    
    /*跳第三頁*/
    @IBSegueAction func actionToThird(_ coder: NSCoder) -> ThirdViewController? {
        
        let controller = ThirdViewController(coder: coder)
        
        if let row = collectionView.indexPathsForSelectedItems?.first?.item {
            controller?.jsonplaceholder = jsonPlaceholderlist[row]
        }
        
        
        return controller
    }
    
    
}
