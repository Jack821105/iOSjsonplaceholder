//
//  Network.swift
//  iOSjsonplaceholder
//
//  Created by 許自翔 on 2020/9/24.
//

import Foundation
import UIKit

class NetworkController{
    
    static let shared = NetworkController()

    
    
    let urlBase = URL(string: "https://jsonplaceholder.typicode.com/photos")!
    
    func getAllProduct(completion: @escaping ([JSONPlaceholder]) -> Void){
        
        var req = URLRequest(url: urlBase)
        req.httpMethod = "GET"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let error = error{
                print("Error: \(error.localizedDescription)")
            }else if let response = response,  let data = data{
                print("狀態:\(response)")
                let decoder = JSONDecoder()
                try! decoder.decode([JSONPlaceholder].self, from: data)
                if let finalData = try? decoder.decode([JSONPlaceholder].self, from: data) {
                    completion(finalData)
                }
            }
            
        }.resume()
        
    }
    
    
}
