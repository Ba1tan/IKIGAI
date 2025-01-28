import SwiftUI

struct KanbanColumnView: View {
    let column: KanbanColumn
    let onAddTask: () -> Void

    var body: some View {
        VStack {
            Text(column.name)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)

            VStack(spacing: 10) {
                ForEach(column.tasks) { task in
                    VStack(alignment: .leading) {
                        Text(task.title)
                            .font(.headline)
                        Text(task.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                }
            }
            .padding(.vertical, 10)

            Button(action: onAddTask) {
                Text("Add Task")
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
            .padding(.top, 10)
        }
        .padding()
        .frame(width: 250)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}
