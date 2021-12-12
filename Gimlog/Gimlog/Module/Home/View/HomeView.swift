//
//  HomeView.swift
//  Gimlog
//
//  Created by Idham on 23/11/21.
//

import SwiftUI
import Common
import GimlogCore
import Game

struct HomeView: View {
    
    @ObservedObject var presenter: GetListPresenter<[String: String], GameModel, Interactor<
        [String: String], [GameModel], GetGamesRepository<
            GetGamesLocaleDataSource, GetGamesRemoteDataSource, GamesTransformer<GameTransformer>>>>
    
    @State private var showModalView = false
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    
    var columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var searchResults: [GameModel] {
        if searchText.isEmpty {
            return self.presenter.list
        } else {
            return self.presenter.list.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        ZStack {
            if presenter.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
            } else {
                if self.presenter.list.count > 0 {
                    ScrollView {
                        searchView.padding(.top)
                        
                        LazyVGrid(columns: columns) {
                            ForEach(searchResults) { game in
                                linkToDetail(for: game.id) {
                                    GameItem(game: game)
                                }
                            }
                        }
                    }
                } else {
                    Text(LocalizedString.dataNotFound).foregroundColor(Color("BlackSoft"))
                }
            }
        }
        .navigationBarTitle(Text("Gimlog"))
        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.large)
        .onAppear {
            if self.presenter.list.count == 0 {
                let request = ["key": API.getApiKey()]
                self.presenter.getList(request: request)
            }
        }
        .navigationBarItems(trailing: HStack {
            Button {} label: {
                linkToFavorite {
                    Image(systemName: "heart.fill").font(.title2).foregroundColor(.white)
                }
            }
            
            Button {showModalView = true} label: {
                Image(systemName: "info.circle.fill").font(.title2).foregroundColor(.white)
            }
            .sheet(isPresented: $showModalView) {
                AboutView()
            }
        })
    }
    
}

extension HomeView {
    
    var searchView: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField(LocalizedString.search, text: $searchText, onEditingChanged: { _ in
                    self.showCancelButton = true
                }, onCommit: {
                    print("onCommit")
                }).foregroundColor(.primary)
                
                Button {
                    self.searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
            
            if showCancelButton {
                Button(LocalizedString.cancel) {
                    UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                    self.searchText = ""
                    self.showCancelButton = false
                }
                .foregroundColor(Color(.orange))
            }
        }
        .padding(.horizontal)
        .navigationBarHidden(showCancelButton).animation(.default)
    }
    
    func linkToDetail<Content: View>(
        for gameId: Int,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: HomeRouter().makeDetailView(for: gameId)) { content() }
    }
    
    func linkToFavorite<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: HomeRouter().makeFavoriteView()) { content() }
    }
    
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter { $0.isKeyWindow }
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged { _ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
