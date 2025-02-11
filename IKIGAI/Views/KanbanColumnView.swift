import SwiftUI

struct KanbanColumnView: View {
    var column: KanbanColumn
    var onAddTask: () -> Void
    var onDropTask: (KanbanTask) -> Void

    var body: some View {
        VStack {
            Text(column.name)
                .font(.headline)
                .padding()

            VStack {
                ForEach(column.tasks) { task in
                    KanbanTaskView(task: task)
                        .onDrag {
                            return NSItemProvider(object: task.title as NSString)
                        }
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .onDrop(of: [.text], isTargeted: nil) { providers in
                if let first = providers.first {
                    _ = first.loadObject(ofClass: NSString.self) { title, _ in
                        if let taskTitle = title as? String {
                            DispatchQueue.main.async {
                                let droppedTask = KanbanTask(title: taskTitle, description: "")
                                onDropTask(droppedTask)
                            }
                        }
                    }
                }
                return true
            }

            Button(action: onAddTask) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.blue)
                    .padding()
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}
