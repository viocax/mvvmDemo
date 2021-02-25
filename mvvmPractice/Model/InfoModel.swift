//
//  InfoModel.swift
//  mvvmPractice
//
//  Created by Jie liang Huang on 2021/2/25.
//

import Foundation

struct InfoModel: Codable {
    let info: [Info]
}

struct Info: Codable {
    let id: String
    let title: String
    let description: String
    let rewards: Int
}
