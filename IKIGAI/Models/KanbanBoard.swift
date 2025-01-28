

import Foundation
struct KanbanBoard: Identifiable {
    let id = UUID()
    var name: String
    var progress: Double
}
