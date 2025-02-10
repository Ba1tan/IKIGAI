import SwiftUI

struct KanbanTaskView: View {
    var task: KanbanTask

    var body: some View {
        VStack {
            Text(task.title)
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(8)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(8)
                .shadow(radius: 3)
                .padding(.vertical, 4)
        }
        .onDrag {
            return NSItemProvider(object: task.title as NSString)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.3)) {}
        }
    }
}
