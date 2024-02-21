//
//  MenuFile.swift
//  Test App
//
//  Created by Work on 1/24/24.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var matchManager: MatchManager
    
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("logo")
                .resizable()
                .scaledToFit()
                .padding(30)
            
            Spacer()
            
            Button {
                matchManager.startMatchmaking()
            } label: {
                Text("Play")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .bold()
            }
            .disabled(matchManager.authenticationState != .authenticated || matchManager.inGame)
            .padding(.vertical, 20)
            .padding(.horizontal, 100)
            .background(
                Capsule(style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .fill(matchManager.authenticationState != .authenticated || matchManager.inGame ? .gray : Color("playBtn"))
            )
            
            Text(matchManager.authenticationState.rawValue)
                .font(.headline.weight(.semibold))
                .foregroundColor(Color("primaryYellow"))
                .padding()
            
            Spacer()
        }
        .background(
            Image("menuBg")
                .resizable()
                .scaledToFit()
                .scaleEffect(1.1)
        )
        .ignoresSafeArea()
    }
}
    
struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(matchManager: MatchManager())
    }
}
