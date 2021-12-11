//
//  DetailView.swift
//  Gimlog
//
//  Created by Idham on 23/11/21.
//

import SwiftUI
import SDWebImageSwiftUI
import AlertToast
import Common
import Core
import Game

struct DetailView: View {
    
    @ObservedObject var presenter: GamePresenter<
        Interactor<[String: String], GameModel, GetGameRepository<
            GetGamesLocaleDataSource, GetGameRemoteDataSource, GameTransformer>>,
        Interactor<Int, GameModel, UpdateFavoriteGameRepository<
            GetFavoriteGamesLocaleDataSource, GameTransformer>>
    >
    
    var gameId: Int
    
    @State private var showToastInserted = false
    @State private var showToastRemoved = false
    
    var body: some View {
        ZStack {
            Color(.orange)
                .ignoresSafeArea()
            
            if presenter.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
            } else {
                if let game = self.presenter.item {
                    ScrollView {
                        VStack {
                            WebImage(url: URL(string: game.backgroundImage))
                                .resizable()
                                .transition(.fade(duration: 0.5))
                                .aspectRatio(contentMode: .fit)
                            
                            Spacer(minLength: 20)
                            
                            Text(game.name)
                                .foregroundColor(Color("BlackSoft"))
                                .font(.system(size: 24))
                                .bold()
                            
                            Spacer(minLength: 20)
                            
                            Group {
                                HStack(alignment: .top) {
                                    Text(LocalizedString.releaseDate)
                                        .foregroundColor(.white)
                                        .font(.system(size: 14))
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    
                                    Text(LocalizedString.rating)
                                        .foregroundColor(.white)
                                        .font(.system(size: 14))
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                }.padding([.horizontal])
                                
                                Spacer(minLength: 4)
                                
                                HStack(alignment: .top) {
                                    Text(game.getReleasedFormatted())
                                        .foregroundColor(Color("BlackSoft"))
                                        .font(.system(size: 16))
                                        .bold()
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    
                                    Text("\(String(game.rating)) ★")
                                        .foregroundColor(Color("BlackSoft"))
                                        .font(.system(size: 16))
                                        .bold()
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                }.padding([.horizontal])
                                
                                Spacer(minLength: 8)
                                
                                HStack(alignment: .top) {
                                    Text(LocalizedString.developer)
                                        .foregroundColor(.white)
                                        .font(.system(size: 14))
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    
                                    Text(LocalizedString.publisher)
                                        .foregroundColor(.white)
                                        .font(.system(size: 14))
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                }.padding([.horizontal])
                                
                                Spacer(minLength: 4)
                                
                                HStack(alignment: .top) {
                                    Text(game.getAllDevelopers())
                                        .foregroundColor(Color("BlackSoft"))
                                        .font(.system(size: 16))
                                        .bold()
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    
                                    Text(game.getAllPublishers())
                                        .foregroundColor(Color("BlackSoft"))
                                        .font(.system(size: 16))
                                        .bold()
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                }.padding([.horizontal])
                            }
                            
                            Spacer(minLength: 20)
                            
                            Text(LocalizedString.about)
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                                .bold()
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                            
                            Spacer()
                            
                            Text(game.description)
                                .foregroundColor(Color("BlackSoft"))
                                .font(.system(size: 16))
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                        }
                    }
                } else {
                    Text(LocalizedString.dataNotFound).foregroundColor(Color("BlackSoft"))
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: HStack {
            Button {
                if self.presenter.item?.favorite == false {
                    self.presenter.updateFavoriteGame(request: gameId) {
                        showToastInserted.toggle()
                    }
                } else {
                    self.presenter.updateFavoriteGame(request: gameId) {
                        showToastRemoved.toggle()
                    }
                }
            } label: {
                if self.presenter.item?.favorite == true {
                    Image(systemName: "heart.fill").font(.title2).foregroundColor(.white)
                } else {
                    Image(systemName: "heart").font(.title2).foregroundColor(.white)
                }
            }
        })
        .onAppear {
            let request = ["id": String(gameId), "key": API.getApiKey()]
            self.presenter.getGame(request: request)
        }
        .toast(isPresenting: $showToastInserted, duration: 1) {
            AlertToast(type: .complete(Color.green), title: LocalizedString.addedToFavorites)
        }
        .toast(isPresenting: $showToastRemoved, duration: 1) {
            AlertToast(displayMode: .banner(.slide),
                       type: .systemImage("info.circle", Color.gray),
                       title: LocalizedString.removedFromFavorites)
        }
    }
}
