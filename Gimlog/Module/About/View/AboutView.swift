//
//  AboutView.swift
//  Gimlog
//
//  Created by Idham on 20/09/21.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color(.orange)
                    .ignoresSafeArea()
                VStack {
                    Text("Created by")
                        .foregroundColor(Color("BlackSoft"))
                        .padding(.top, 100)
                    
                    Image("idham")
                        .resizable()
                        .transition(.fade(duration: 0.5))
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding()
                    
                    Text("Idham M Irfani")
                        .foregroundColor(Color("BlackSoft"))
                        .font(.system(size: 18))
                        .bold()
                    
                    Text("idham.m.irfani@gmail.com")
                        .foregroundColor(Color("BlackSoft"))
                        .padding(.top, 2)
                }
            }
            .navigationTitle("About")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "x.circle.fill")
                    .font(.title2)
            })
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
