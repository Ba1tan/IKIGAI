import SwiftUI

struct KanbanBoardView: View {
    var boardName: String
    @State private var columns: [KanbanColumn] = [
        KanbanColumn(name: "ToDo", tasks: []),
        KanbanColumn(name: "In Progress", tasks: []),
        KanbanColumn(name: "Done", tasks: [])
    ]
    @State private var showAddTaskSheet = false
    @State private var selectedColumnIndex: Int?

    var body: some View {
        NavigationView {
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(Array(columns.enumerated()), id: \.offset) { index, column in
                        KanbanColumnView(
                            column: column,
                            onAddTask: { showAddTaskSheet = true; selectedColumnIndex = index },
                            onDropTask: { task in moveTask(task, to: index) }
                        )
                    }
                }
                .padding()
            }
            .navigationTitle(boardName)
            .sheet(isPresented: $showAddTaskSheet) {
                if let index = selectedColumnIndex {
                    AddTaskView { title, description in
                        withAnimation {
                            addTask(to: index, title: title, description: description)
                        }
                    }
                }
            }
        }
    }

    private func addTask(to columnIndex: Int, title: String, description: String) {
        let newTask = KanbanTask(title: title, description: description)
        columns[columnIndex].tasks.append(newTask)
    }

    private func moveTask(_ task: KanbanTask, to columnIndex: Int) {
        for i in 0..<columns.count {
            if let index = columns[i].tasks.firstIndex(of: task) {
                columns[i].tasks.remove(at: index)
                break
            }
        }
        withAnimation {
            columns[columnIndex].tasks.append(task)
        }
    }
}
