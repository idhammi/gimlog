//
//  GameDetail.swift
//  Gimlog
//
//  Created by Idham on 16/09/21.
//

import SwiftUI
import SDWebImageSwiftUI
import AlertToast

struct GameDetail: View {
    
    var gameId: Int
    
    @ObservedObject var vm = DetailViewModel()
    
    @State private var showToastInserted = false
    @State private var showToastRemoved = false
    
    var body: some View {
        ZStack {
            Color(.orange)
                .ignoresSafeArea()
            
            if vm.loading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
            }
            
            if let game = vm.gameDetail {
                ScrollView {
                    VStack {
                        WebImage(url: URL(string: game.backgroundImage ?? ""))
                            .resizable()
                            .transition(.fade(duration: 0.5))
                            .aspectRatio(contentMode: .fit)
                        
                        Spacer(minLength: 20)
                        
                        Text(game.name ?? "")
                            .foregroundColor(Color("BlackSoft"))
                            .font(.system(size: 24))
                            .bold()
                        
                        Spacer(minLength: 20)
                        
                        Group {
                            HStack(alignment: .top) {
                                Text("Release Date")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                                Text("Rating")
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
                                
                                Text("\(game.getRatingString()) ★")
                                    .foregroundColor(Color("BlackSoft"))
                                    .font(.system(size: 16))
                                    .bold()
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            }.padding([.horizontal])
                            
                            Spacer(minLength: 8)
                            
                            HStack(alignment: .top) {
                                Text("Developer")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                                Text("Publisher")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            }.padding([.horizontal])
                            
                            Spacer(minLength: 4)
                            
                            HStack(alignment: .top) {
                                Text(game.getAllDevelopers() ?? "-")
                                    .foregroundColor(Color("BlackSoft"))
                                    .font(.system(size: 16))
                                    .bold()
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                                Text(game.getAllPublishers() ?? "-")
                                    .foregroundColor(Color("BlackSoft"))
                                    .font(.system(size: 16))
                                    .bold()
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            }.padding([.horizontal])
                        }
                        
                        Spacer(minLength: 20)
                        
                        Text("About")
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                            .bold()
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                        
                        Spacer()
                        
                        Text(game.description ?? "")
                            .foregroundColor(Color("BlackSoft"))
                            .font(.system(size: 16))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                    }
                }
            } else {
                if !vm.loading {
                    Text("Data not found")
                        .foregroundColor(Color("BlackSoft"))
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: HStack {
            Button {
                if !vm.isFavorite {
                    if let game = vm.gameDetail {
                        vm.setGameAsFavorite(item: game) {
                            showToastInserted.toggle()
                        }
                    }
                } else {
                    vm.removeGameFromFavorite(gameId: gameId) {
                        showToastRemoved.toggle()
                    }
                }
            } label: {
                if vm.isFavorite {
                    Image(systemName: "heart.fill").font(.title2)
                } else {
                    Image(systemName: "heart").font(.title2)
                }
            }
        })
        .onAppear {
            vm.getGameDetail(gameId: gameId)
        }
        .toast(isPresenting: $showToastInserted, duration: 1) {
            AlertToast(type: .complete(Color.green), title: "Added to favorites!")
        }
        .toast(isPresenting: $showToastRemoved, duration: 1) {
            AlertToast(displayMode: .banner(.slide),
                       type: .systemImage("info.circle", Color.gray),
                       title: "Removed from favorites")
        }
    }
}

struct GameDetail_Previews: PreviewProvider {
    static var previews: some View {
        GameDetail(gameId: 3498)
    }
}
