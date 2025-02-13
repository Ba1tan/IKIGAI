import SwiftUI

struct KanbanTaskView: View {
    var task: Card
    // Closure to handle deletion of this task
    var onDelete: () -> Void = {}
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(task.title)
                .font(.headline)
                .foregroundColor(.primary)
            Text(task.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
        .contextMenu {
            Button(role: .destructive) {
                onDelete()
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

