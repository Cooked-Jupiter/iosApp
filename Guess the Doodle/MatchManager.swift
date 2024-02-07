//
//  MatchMaker.swift
//  Test App
//
//  Created by Work on 1/24/24.
//

import Foundation

class MatchManager: ObservableObject {
    @Published var authenticationState = PlayerAuthState.authenticating
    @Published var isGameOver = false
    @Published var inGame = false
    
    @Published var currentlyDrawing = false
    @Published var drawPrompt =  ""
    @Published var pastGuesses = [PastGuess]()
    
    @Published var score = 0
    @Published var remainingTime = maxTimeRemaining
}
