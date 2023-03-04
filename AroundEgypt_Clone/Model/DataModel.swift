//
//  DataModel.swift
//  AroundEgypt_Clone
//
//  Created by Ziad Alfakharany on 03/03/2023.
//

import Foundation

struct DataModel: Codable {
    let data:[data]
}

struct data: Codable {
    let id: String
    let title: String
    let cover_photo: String
    let likes_no: Int
    let description: String
}
