//
//  MockParser.swift
//  Havit
//
//  Created by SHIN YOON AH on 2022/01/14.
//

import Foundation

final class MockParser {
    static func load<T: Decodable>(type: T.Type, fileName: String) -> T? {
        guard let path = Bundle(for: MockParser.self).path(forResource: fileName, ofType: "json") else {
            return nil
        }
        let fileURL = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: fileURL) else {
            return nil
        }
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
            return nil
        }
        guard let decodable = try? JSONSerialization.data(withJSONObject: jsonObject) else { return nil }
        return try? JSONDecoder().decode(type, from: decodable)
    }
}
