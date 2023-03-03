//
//  DataModel.swift
//  AroundEgypt_Clone
//
//  Created by Ziad Alfakharany on 03/03/2023.
//

import Foundation

struct DataModel: Codable {
    //let meta:[meta]
    let data:[data]
}

//struct meta: Codable {
//    let code: Int
//    let errors: [String]
//}

struct data: Codable {
    let id: String
    let title: String
    let cover_photo: String
    let likes_no: Int
}
