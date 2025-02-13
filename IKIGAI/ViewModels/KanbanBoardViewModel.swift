import Foundation
import SwiftUI

@MainActor
class KanbanViewModel: ObservableObject {
    @Published var kanbanBoard: KanbanBoard?
    @Published var showAddTask = false
    private let storage: KanbanStorageService
    
    init(storage: KanbanStorageService = KanbanStorageService()) {
        self.storage = storage
        Task {
            await loadKanban()
        }
    }
    
    func tasksForStatus(_ status: String) -> [Card] {
        return kanbanBoard?.cards.filter { $0.status == status } ?? []
    }
    
    func addTask(_ task: Card) {
        Task {
            try? await storage.addCard(task)
            await loadKanban()
        }
    }
    
    func updateCardStatus(cardID: String, newStatus: String) {
        Task {
            try? await storage.updateCardStatus(cardID: cardID, newStatus: newStatus)
            await loadKanban()
        }
    }
    
    // New deletion function for a task
    func deleteTask(cardID: String) {
        Task {
            try? await storage.deleteCard(cardID: cardID)
            await loadKanban()
        }
    }
    
    private func loadKanban() async {
        do {
            kanbanBoard = try await storage.loadKanban()
        } catch {
            print("Failed to load kanban:", error)
        }
    }
}

