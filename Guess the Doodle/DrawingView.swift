//
//  DrawingView.swift
//  Guess the Doodle
//
//  Created by Work on 2/14/24.
//

import SwiftUI
import PencilKit

struct DrawingView: UIViewRepresentable {
    class Coordinator: NSObject, PKCanvasViewDelegate {
        var matchManager: MatchManager
        
        init(matchManager: MatchManager) {
            self.matchManager = matchManager
        }
        
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            // TODO: Send the new drawing data
        }
    }
    
    var canvasView = PKCanvasView()
    
    @ObservedObject var matchManager: MatchManager
    @Binding var eraserEnabled: Bool
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawingPolicy = .anyInput
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 5)
        canvasView.delegate = context.coordinator
        canvasView.isUserInteractionEnabled = matchManager.currentlyDrawing
        
        return canvasView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(matchManager: matchManager)
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context)
    {
        // Handle UI updates
        
        canvasView.tool = eraserEnabled ? PKEraserTool(.vector) : PKInkingTool(.pen, color: .black, width: 5)
    }
}

struct DrawingView_Previews: PreviewProvider {
    @State static var erasor = false
    static var previews: some View {
        DrawingView(matchManager: MatchManager(),
        eraserEnabled: $erasor)
    }
}
