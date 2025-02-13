import SwiftUI

struct KanbanBoardView: View {
    @StateObject private var viewModel = KanbanViewModel()
    var board: KanbanBoard?
    
    init(board: KanbanBoard? = nil) {
        self.board = board
    }
    
    var body: some View {
        VStack {
            if let board = board {
                Text(board.title)
                    .font(.largeTitle)
                    .padding()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(TaskStatus.allCases, id: \.self) { status in
                        KanbanColumnView(
                            status: status.rawValue,
                            tasks: viewModel.tasksForStatus(status.rawValue),
                            onAddTask: {
                                viewModel.showAddTask = true
                            },
                            onDropTask: { task in
                                viewModel.addTask(task)
                            },
                            onDeleteTask: { cardID in
                                viewModel.deleteTask(cardID: cardID)
                            }
                        )
                    }
                }
                .padding()
            }
        }
        .navigationTitle(board?.title ?? "Kanban Board")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.showAddTask = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $viewModel.showAddTask) {
            AddTaskView(viewModel: viewModel)
        }
    }
}

