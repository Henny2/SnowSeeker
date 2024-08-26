//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Henrieke Baunack on 8/18/24.
//

import SwiftUI

@Observable
class Favorites {
//    private var resorts: Set<String>
    private var resorts: Set<String>
    private let key = "Favorites"
    
    init() {
        
//    https://www.hackingwithswift.com/books/ios-swiftui/saving-and-loading-data-with-userdefaults
        if let data = UserDefaults.standard.data(forKey: key) {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                resorts = decoded
                return
            }
        }

        resorts = []
//        resorts = []
    }
    
    func contain(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort){
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
//        let test = ["les-trois-vallees"]
        print(resorts)
//        UserDefaults.standard.set(resorts, forKey: key)
        if let encoded = try? JSONEncoder().encode(resorts) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
    }
}
