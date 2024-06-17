//
//  Bunde-Decodable.swift
//  SnowSeeker
//
//  Created by Henrieke Baunack on 6/16/24.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in the Bundle.")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from Bundle.")
        }
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context){
            // e.g. key not found - example description not found
            fatalError("Failed to decode \(file) due to missing key '\(key)' - \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context){
            // if the key exists but is seeing an int for a key that is supposed to be a string
            fatalError("Failed to decode \(file) due to type mismatch - \(context.debugDescription)")
        } catch DecodingError.valueNotFound(_, let context){
            fatalError("Failed to decode \(file) due to missing value -\(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) because of invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) because of \(error.localizedDescription)")
        }
    }
}
