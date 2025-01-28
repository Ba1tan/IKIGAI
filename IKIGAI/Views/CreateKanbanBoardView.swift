import SwiftUI


struct CreateKanbanBoardView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    var onCreate: (String) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("New Board")) {
                    TextField("Board Name", text: $name)
                }
            }
            .navigationTitle("Create Board")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        onCreate(name)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}
