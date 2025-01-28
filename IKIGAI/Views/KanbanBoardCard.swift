import SwiftUI
import Foundation

struct KanbanBoardCard: View {
    var board: KanbanBoard
    
    var body: some View {
        VStack {
            Text(board.name)
                .font(.headline)
                .padding(.bottom, 8)
            
            ProgressView(value: board.progress)
                .progressViewStyle(LinearProgressViewStyle())
        }
        .padding()
        .frame(width: 200)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}
