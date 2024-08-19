//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Henrieke Baunack on 6/16/24.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass // tell us whether we have a regular or compact horizontal size class
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                
                HStack{
                    if horizontalSizeClass == .compact && dynamicTypeSize > .large {
                        VStack(spacing: 10) {
                            ResortDetailsView(resort: resort)
                        }
                        VStack(spacing: 10) {
                            SkiDetailsView(resort: resort)
                        }
                    } else {
                        // both the following view use groups i.e. they are layout neutral
                        // that's why they are put all in line based on the hstack
                        // and in the if clause, they are stacked bc of the vstack
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                    
                }
                .padding(.vertical)
                .background(.primary.opacity(0.1))
                
                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    Text("Facilities")
                        .font(.headline)
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            Button {
                                selectedFacility = facility
                                showingFacility = true
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        //presenting unwraps for us the optional
        .alert(selectedFacility?.name ?? "more information", isPresented: $showingFacility, presenting: selectedFacility) { _ in
            // we don't care about the facility here, we are cool with just the default OK button
        } message: { facility in
            Text(facility.description)
        }
    }
}

#Preview {
    ResortView(resort: .example)
}

