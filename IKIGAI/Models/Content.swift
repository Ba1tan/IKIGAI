
import Foundation

struct Content: Codable, Identifiable {
    var id: String { contentID }
    var contentID: String
    var contentText: String
    
}
