import Foundation

class KanbanStorageService {
    private let fileName: String
    
    init(fileName: String = "kanban.json") {
        self.fileName = fileName
    }
    
    private func getFileURL() -> URL? {
        let fileManager = FileManager.default
        if let directory = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
            let fileURL = directory.appendingPathComponent(fileName)
            
            if !fileManager.fileExists(atPath: directory.path) {
                do {
                    try fileManager.createDirectory(at: directory, withIntermediateDirectories: true)
                } catch {
                    print("❌ Ошибка создания директории: \(error.localizedDescription)")
                    return nil
                }
            }
            return fileURL
        }
        return nil
    }
    
    func loadKanban() async throws -> KanbanBoard {
        guard let fileURL = getFileURL() else {
            throw NSError(domain: "KanbanStorage", code: 1, userInfo: [NSLocalizedDescriptionKey: "Невозможно получить URL файла"])
        }
        
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: fileURL.path) {
            // Try to copy bundled file if available, otherwise create default board
            if let bundledURL = Bundle.main.url(forResource: "kanban", withExtension: "json") {
                do {
                    try fileManager.copyItem(at: bundledURL, to: fileURL)
                    print("Copied bundled kanban.json to \(fileURL.path)")
                } catch {
                    print("❌ Ошибка копирования bundled kanban.json: \(error.localizedDescription)")
                    let defaultBoard = KanbanBoard(title: "Default Board", admin: "Admin")
                    try await saveKanban(defaultBoard)
                }
            } else {
                let defaultBoard = KanbanBoard(title: "Default Board", admin: "Admin")
                try await saveKanban(defaultBoard)
            }
        }
        
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(KanbanBoard.self, from: data)
    }
    
    func saveKanban(_ kanban: KanbanBoard) async throws {
        guard let fileURL = getFileURL() else {
            throw NSError(domain: "KanbanStorage", code: 1, userInfo: [NSLocalizedDescriptionKey: "Невозможно получить URL файла"])
        }
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        
        let data = try encoder.encode(kanban)
        try data.write(to: fileURL)
    }
    
    func updateCardStatus(cardID: String, newStatus: String) async throws {
        var kanban = try await loadKanban()
        if let index = kanban.cards.firstIndex(where: { $0.cardID == cardID }) {
            kanban.cards[index].status = newStatus
            try await saveKanban(kanban)
        }
    }
    
    func addCard(_ card: Card) async throws {
        var kanban = try await loadKanban()
        kanban.cards.append(card)
        try await saveKanban(kanban)
    }
    
    func addParticipant(_ participant: String) async throws {
        var kanban = try await loadKanban()
        if !kanban.participants.contains(participant) {
            kanban.participants.append(participant)
            try await saveKanban(kanban)
        }
    }
    
    func deleteCard(cardID: String) async throws {
        var kanban = try await loadKanban()
        if let index = kanban.cards.firstIndex(where: { $0.cardID == cardID }) {
            kanban.cards.remove(at: index)
            try await saveKanban(kanban)
        }
    }
}

