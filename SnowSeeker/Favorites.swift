//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Henrieke Baunack on 8/18/24.
//

import SwiftUI

@Observable
class Favorites {
    private var resorts: Set<String>
    private let key = "Favorites"
    
    init() {
        resorts = []
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
        
    }
}
