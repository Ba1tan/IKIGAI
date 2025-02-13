import Foundation

struct KanbanBoard: Codable, Identifiable {
    var id: String { kanbanID }
    var kanbanID: String
    var title: String
    var admin: String
    var participants: [String]
    var dateOfCreation: Date
    var description: String
    var cards: [Card]
    var content: [Content]

init(
   kanbanID: String = UUID().uuidString,
   title: String,
   admin: String,
   participants: [String] = [],
   dateOfCreation: Date = Date(),
   description: String = "",
   cards: [Card] = [],
   content: [Content] = []
) {
   self.kanbanID = kanbanID
   self.title = title
   self.admin = admin
   self.participants = participants
   self.dateOfCreation = dateOfCreation
   self.description = description
   self.cards = cards
   self.content = content
}
}
extension KanbanBoard {
    init(title: String, admin: String = "CurrentUser") {
        self.init(
            kanbanID: UUID().uuidString,
            title: title,
            admin: admin,
            participants: [],
            dateOfCreation: Date(),
            description: "",
            cards: [],
            content: []
        )
    }
}

