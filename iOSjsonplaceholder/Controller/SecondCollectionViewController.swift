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
        
        
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NetworkController.shared.getAllProduct { (i :[JSONPlaceholder]) in
            if i != nil{
                self.jsonPlaceholderlist = i
                
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
        
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
        
        let jsonPlaceholder = jsonPlaceholderlist[indexPath.item]
        
        
        
        if let url = URL(string: jsonPlaceholder.thumbnailUrl){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error{
                    print("Error: \(error.localizedDescription)")
                }else if let response = response,let data = data{
                    print("狀態\(response)")
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell?.ivThumbnailUrl.image=image
                    }
                }
            }.resume()
            
            
        }
        
        
        cell?.lbID.text = String(jsonPlaceholder.id)
        cell?.lbTitle.text = jsonPlaceholder.title
        
        
        if let cell = cell {
            return cell
        }else{
            return UICollectionViewCell()
        }
        
    }
    
    
    @IBSegueAction func actionToThird(_ coder: NSCoder) -> ThirdViewController? {
        
        let controller = ThirdViewController(coder: coder)
        
        if let row = collectionView.indexPathsForSelectedItems?.first?.item {
            controller?.jsonplaceholder = jsonPlaceholderlist[row]
        }
        
        
        return controller
    }
    
    
}
