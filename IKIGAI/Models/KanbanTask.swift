import Foundation
struct Card: Codable, Identifiable {
    var id: String { cardID }
    var cardID: String
    var title: String
    var description: String    // ← Added property
    var whoCreated: String
    var dateOfCreation: Date
    var color: String
    var status: String
    var contentID: String
    var whoMakes: String
    var datesOfProgress: Date?
    var whoDone: String
    var dateOfDone: Date?
    
    init(
        cardID: String = UUID().uuidString,
        title: String,
        description: String = "",  // ← Default value provided
        whoCreated: String = "Unknown",
        dateOfCreation: Date = Date(),
        color: String = "#FFFFFF",
        status: String = TaskStatus.todo.rawValue,
        contentID: String = UUID().uuidString,
        whoMakes: String = "Unknown",
        datesOfProgress: Date? = nil,
        whoDone: String = "",
        dateOfDone: Date? = nil
    ) {
        self.cardID = cardID
        self.title = title
        self.description = description
        self.whoCreated = whoCreated
        self.dateOfCreation = dateOfCreation
        self.color = color
        self.status = status
        self.contentID = contentID
        self.whoMakes = whoMakes
        self.datesOfProgress = datesOfProgress
        self.whoDone = whoDone
        self.dateOfDone = dateOfDone
    }
}

