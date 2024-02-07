//
//  MenuFile.swift
//  Test App
//
//  Created by Work on 1/24/24.
//

import SwiftUI

struct GameOverView: View {
    @ObservedObject var matchManager: MatchManager
    
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("gameOver")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 70)
                .padding(.vertical)
            
            Text("Score: \(matchManager.score)")
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color("primaryYellow"))
            
            Spacer()
            
            Button {
                // TODO Start Match making
            } label: {
                Text("Menu")
                    .foregroundColor(Color("menuBtn"))
                    .brightness(-0.4)
                    .font(.largeTitle)
                    .bold()
            }
            .padding()
            .padding(.horizontal, 50)
            .background(
                Capsule(style: .circular)
                    .fill(Color("menuBtn"))
            )
            
            Spacer()
        }
        .background(
            Image("gameOverBg")
                .resizable()
                .scaledToFit()
                .scaleEffect(1.1)
        )
        .ignoresSafeArea()
    }
}
    
struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(matchManager: MatchManager())
    }
}
