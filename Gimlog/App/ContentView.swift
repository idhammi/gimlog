//
//  ContentView.swift
//  Gimlog
//
//  Created by Idham on 16/09/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var homePresenter: HomePresenter
    
    var body: some View {
        NavigationView {
            HomeView(presenter: homePresenter)
        }
        .navigationAppearance(
            backgroundColor: .orange, foregroundColor: .systemBackground,
            tintColor: .systemBackground, hideSeparator: true
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
