import SwiftUI

struct MainMenuView: View {
    @State
    private var kanbanBoards: [KanbanBoard] = []
    @State
    private var showCreateBoardSheet = false

var body: some View {
    NavigationView {
        VStack {
            // Top header
            HStack {
                Spacer()
                Text("IKIGAI")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                Spacer()
            }
            .padding()
            
            // Boards header
            Text("Your Kanban Boards")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            // Horizontal list of boards
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(kanbanBoards) { board in
                        NavigationLink(destination: KanbanBoardView(board: board)) {
                            KanbanBoardCard(board: board)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            Divider()
                .padding(.vertical)
            
            Spacer()
            
            // Bottom navigation
            HStack {
                NavigationLink(destination: MainMenuView()) {
                    Image(systemName: "house.fill")
                        .font(.system(size: 24))
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.blue)
                }
                
                Button(action: {
                    showCreateBoardSheet = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 48))
                        .foregroundColor(.blue)
                        .padding(.bottom, 10)
                }
                .frame(maxWidth: .infinity)
                
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 24))
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.blue)
                }
            }
            .frame(height: 60)
            .background(Color.gray.opacity(0.1))
            .sheet(isPresented: $showCreateBoardSheet) {
                CreateKanbanBoardView { name in
                    let newBoard = KanbanBoard(title: name)
                    kanbanBoards.append(newBoard)
                }
            }
        }
        .navigationBarHidden(true)
    }
}
}

struct MainMenuView_Previews: PreviewProvider { static var previews: some View { MainMenuView() } }
