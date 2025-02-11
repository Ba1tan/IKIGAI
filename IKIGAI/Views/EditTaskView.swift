import SwiftUI

struct EditTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String
    @State private var description: String
    var onSave: (String, String) -> Void

    init(task: KanbanTask, onSave: @escaping (String, String) -> Void) {
        self._title = State(initialValue: task.title)
        self._description = State(initialValue: task.description)
        self.onSave = onSave
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit Task")) {
                    TextField("Task Title", text: $title)
                    TextField("Task Description", text: $description)
                }
            }
            .navigationTitle("Edit Task")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(title, description)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}
