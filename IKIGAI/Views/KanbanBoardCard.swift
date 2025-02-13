import Foundation
import SwiftUI

struct KanbanBoardCard: View {
    var board: KanbanBoard
    
    var body: some View {
        VStack {
            Text(board.title)
                .font(.headline)
                .padding(.bottom, 8)
            
            if board.cards.count > 0 {
                let completed = board.cards.filter { $0.status == TaskStatus.done.rawValue }.count
                let progress = Double(completed) / Double(board.cards.count)
                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle())
            } else {
                Text("No tasks")
            }
        }
        .padding()
        .frame(width: 200)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

