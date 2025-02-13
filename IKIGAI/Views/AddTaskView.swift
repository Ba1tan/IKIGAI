import SwiftUI

struct AddTaskView: View {
@ObservedObject
var viewModel: KanbanViewModel
@Environment(\.dismiss)
private var dismiss

@State private var title = ""
@State private var description = ""
@State private var status = TaskStatus.todo.rawValue

var body: some View {
    NavigationView {
        Form {
            Section(header: Text("Task Details")) {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
                Picker("Status", selection: $status) {
                    ForEach(TaskStatus.allCases, id: \.self) { status in
                        Text(status.rawValue).tag(status.rawValue)
                    }
                }
            }
        }
        .navigationTitle("New Task")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") { dismiss() }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add") {
                    let task = Card(title: title, description: description, status: status)
                    viewModel.addTask(task)
                    dismiss()
                }
                .disabled(title.isEmpty)
            }
        }
    }
}
}
