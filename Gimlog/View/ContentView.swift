//
//  ContentView.swift
//  Gimlog
//
//  Created by Idham on 16/09/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showNavView = false
    @State private var showModalView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                GameList()
                    .navigationBarTitle(Text("Gimlog"))
                    .navigationBarItems(trailing: Button {
                        showModalView = true
                    } label: {
                        Image(systemName: "info.circle.fill").font(.title2)
                    })
                    .sheet(isPresented: $showModalView) {
                        AboutView()
                    }
            }
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
