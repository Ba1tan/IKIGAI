
import SwiftUI

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String = ""
    @State private var description: String = ""

    var onSave: (String, String) -> Void

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Task Details")) {
                        TextField("Task Title", text: $title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Task Description", text: $description)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                .padding()

                Button(action: {
                    if !title.isEmpty {
                        onSave(title, description)
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Save Task")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .disabled(title.isEmpty)
            }
            .navigationTitle("Add Task")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

