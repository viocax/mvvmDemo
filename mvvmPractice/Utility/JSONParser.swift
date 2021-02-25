//
//  JSONParser.swift
//  mvvmPractice
//
//  Created by Jie liang Huang on 2021/2/25.
//

import Foundation

struct JSONParser {
    enum ParserError: Error {
        case bundleError
    }
    static func getJSON<T: Decodable>(decodeTo type: T.Type, fileName: String) throws -> T {
        guard
            let bundlePath = Bundle.main.path(forResource: fileName, ofType: "json") else {
            throw ParserError.bundleError
        }
        let url = URL(fileURLWithPath: bundlePath)
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw error
        }
    }
}
