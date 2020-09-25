//
//  ThirdViewController.swift
//  iOSjsonplaceholder
//
//  Created by 許自翔 on 2020/9/24.
//

import UIKit

class ThirdViewController: UIViewController {
    
    var jsonplaceholder:JSONPlaceholder?
    
    
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbID: UILabel!
    @IBOutlet weak var ivJson: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lbTitle.lineBreakMode = NSLineBreakMode.byTruncatingHead

        
        lbID.text = "id:\(jsonplaceholder?.id ?? 0)"
        lbTitle.text = "title:"+jsonplaceholder!.title
        
        if let url = URL(string: jsonplaceholder!.url){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error{
                    print("Error: \(error.localizedDescription)")
                }else if let response = response,let data = data{
                    print("狀態\(response)")
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.ivJson.image=image
                    }
                }
            }.resume()
            
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
