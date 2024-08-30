//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Henrieke Baunack on 6/9/24.
//

import SwiftUI

struct ContentView: View {
    
    enum SortOrder {
        case alphabetical, byCountry
    }
    // for sorting a list: https://xavier7t.com/swiftui-list-with-sort-options
    // menu button for sorting: https://www.hackingwithswift.com/books/ios-swiftui/dynamically-sorting-and-filtering-query-with-swiftui
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var sortedResorts: [Resort] {
        if sortOrder == .alphabetical {
            return resorts.sorted { $0.name < $1.name }
        }
        else if sortOrder == .byCountry {
            return resorts.sorted { $0.country < $1.country }
        }
        else {
            return resorts
        }
    }
    
    @State private var favorites = Favorites()
    @State private var searchText = ""
    @State private var sortOrder: SortOrder = .alphabetical
   
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            sortedResorts
        } else {
            sortedResorts.filter {
                $0.name.localizedStandardContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List(filteredResorts) { resort in
                NavigationLink(value: resort) {
                    HStack{
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(.rect(cornerRadius:5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5).stroke(.black, lineWidth: 1)
                            )
                        VStack(alignment: .leading){
                            Text(resort.name)
                                .font(.headline)
                            HStack {
                                Text(resort.country)
                                    .foregroundStyle(.secondary)
                                Text("•")
                                    .foregroundStyle(.secondary)
                                Text("\(resort.runs) runs")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        
                        if favorites.contain(resort){
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort.")
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name").tag(SortOrder.alphabetical)
                        Text("Sort by Country").tag(SortOrder.byCountry)
                    }
                }
            }
                
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }
}

#Preview {
    ContentView()
}
