import SwiftUI
import Foundation

struct EditTaskView: View {
    @Environment(\.dismiss)
    private var dismiss
    @State
    private var title: String
    @State
    private var description: String
    var onSave: (String, String) -> Void

init(task: Card, onSave: @escaping (String, String) -> Void) {
    _title = State(initialValue: task.title)
    _description = State(initialValue: task.description)
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
                    dismiss()
                }
            }
        }
    }
}
}


