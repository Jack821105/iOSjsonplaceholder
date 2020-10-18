//
//  SecondCollectionViewCell.swift
//  iOSjsonplaceholder
//
//  Created by 許自翔 on 2020/9/24.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {
    
    
    var jsonP: JSONPlaceholder!
    @IBOutlet weak var lbID: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var ivThumbnailUrl: UIImageView!
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(nil)
                }
            }.resume()
        }
    
    func update() {
        let id = jsonP.id
        lbID.text = String(id)
        lbTitle.text = jsonP.title
        ivThumbnailUrl.image = UIImage(systemName: "questionmark.circle")
        let req = URL(string: jsonP.thumbnailUrl)
        fetchImage(url: req!) { (image) in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    /*判斷id是否一樣*/
                    if id == self.jsonP.id{
                        self.ivThumbnailUrl.image = image
                    }
                }
            }
        }
    
    
    
}
