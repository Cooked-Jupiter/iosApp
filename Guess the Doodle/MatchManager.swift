//
//  MatchMaker.swift
//  Test App
//
//  Created by Work on 1/24/24.
//

import Foundation
import GameKit
import PencilKit

class MatchManager: NSObject, ObservableObject {
    @Published var authenticationState = PlayerAuthState.authenticating
    @Published var isGameOver = false
    @Published var inGame = false
    
    @Published var currentlyDrawing = false
    @Published var drawPrompt =  ""
    @Published var pastGuesses = [PastGuess]()
    
    @Published var score = 0
    @Published var remainingTime = maxTimeRemaining
    @Published var lastReceivedDrawing = PKDrawing()
    @Published var isTimeKeeper = false
    
    var match: GKMatch?
    var otherPlayer: GKPlayer?
    var localPlayer = GKLocalPlayer.local
    
    var playerUUIDKey = UUID().uuidString
    
    var rootViewController: UIViewController? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }
    
    func authenticateUser() {
        GKLocalPlayer.local.authenticateHandler = { [self] vc, e in
            if let viewController = vc {
                rootViewController?.present(viewController, animated: true)
                return
            }
            
            if let error = e {
                authenticationState = .error
                print(error.localizedDescription)
                
                return
            }
            
            if localPlayer.isAuthenticated {
                if localPlayer.isMultiplayerGamingRestricted {
                    authenticationState = .restricted
                } else {
                    authenticationState = .authenticated
                }
            } else {
                authenticationState = .unauthenticated
            }
        }
    }
    
    func startMatchmaking() {
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 2
        
        let matchmakingVC = GKMatchmakerViewController(matchRequest: request)
        matchmakingVC?.matchmakerDelegate = self
        
        rootViewController?.present(matchmakingVC!, animated: true)
    }
    
    func startGame(newMatch: GKMatch) {
        match = newMatch
        match?.delegate = self
        otherPlayer = match?.players.first
        drawPrompt = everydayObjects.randomElement()!
        
        sendString("began:\(playerUUIDKey)")
    }
    
    func receivedString(_ message: String) {
        let messageSplit = message.split(separator: ":")
        guard let messagePrefix = messageSplit.first else {return}
        
        let parameter = String(messageSplit.last ?? "")
        
        switch messagePrefix {
        case "began":
            if playerUUIDKey == parameter{
                playerUUIDKey = UUID().uuidString
                sendString("begin:\(playerUUIDKey)")
                break
            }
            
            currentlyDrawing = playerUUIDKey < parameter
            inGame = true
            isTimeKeeper = true
            
            if isTimeKeeper {
                countdownTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            }
            
        default:
            break
        }
    }
}
