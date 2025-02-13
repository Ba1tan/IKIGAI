import SwiftUI

struct KanbanColumnView: View {
    var status: String
    var tasks: [Card]
    var onAddTask: () -> Void = {}
    var onDropTask: (Card) -> Void = { _ in }
    var onDeleteTask: (String) -> Void = { _ in }
    
    var body: some View {
        VStack {
            Text(status)
                .font(.headline)
                .padding()
            
            VStack {
                ForEach(tasks) { task in
                    KanbanTaskView(task: task, onDelete: {
                        onDeleteTask(task.cardID)
                    })
                    .onDrag {
                        NSItemProvider(object: task.title as NSString)
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
                                let droppedTask = Card(title: taskTitle, description: "", status: status)
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

