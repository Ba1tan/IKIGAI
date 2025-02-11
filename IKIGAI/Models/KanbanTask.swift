import Foundation

struct KanbanTask: Identifiable, Codable, Hashable {
    var id: UUID
    var title: String
    var description: String

    init(id: UUID = UUID(), title: String, description: String) {
        self.id = id
        self.title = title
        self.description = description
    }
}
