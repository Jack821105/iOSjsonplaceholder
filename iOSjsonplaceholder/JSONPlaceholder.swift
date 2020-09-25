//
//  JSONPlaceholder.swift
//  iOSjsonplaceholder
//
//  Created by 許自翔 on 2020/9/24.
//

import Foundation

//建立物件

struct JSONPlaceholder:Codable {
    
    let albumId:Int
    let id:Int
    let title:String
    let url:String
    let thumbnailUrl:String
    
}
