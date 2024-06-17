//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Henrieke Baunack on 6/16/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        Text("Welcome to SnowSeeker!")
            .font(.largeTitle)
        Text("Please select a resort from the left-hand menu.").foregroundStyle(.secondary)
    }
}

#Preview {
    WelcomeView()
}
