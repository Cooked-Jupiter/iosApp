//
//  MatchManager+GKMatchDelegate.swift
//  Guess the Doodle
//
//  Created by Work on 2/20/24.
//

import Foundation
import GameKit
import PencilKit

extension MatchManager: GKMatchDelegate {
    func match(_ match: GKMatch, didReceive data: Data, fromPlayer playerID: String) {
        let content = String(decoding: data, as: UTF8.self)
        
        if content.starts(with: "strData") {
            let message = content.replacing("strData:", with: "")
            receivedString(message)
        } else {
            do {
                try lastReceivedDrawing = PKDrawing(data: data)
            } catch {
                print(error)
            }
        }
    }
    
    func sendString(_ message: String) {
        guard let encoded = "strData:\(message)".data(using: .utf8) else { return }
        sendData(encoded, mode: .reliable)
    }
    
    func sendData(_ data: Data, mode: GKMatch.SendDataMode) {
        do {
            try match?.sendData(toAllPlayers: data, with: mode)
        } catch {
            print(error)
        }
    }
    
    func match(_ match: GKMatch, player: GKPlayer, didChange state: GKPlayerConnectionState) {
        
    }
}
