import SwiftUI

struct KanbanTaskView: View {
    var task: KanbanTask

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
    }
}
