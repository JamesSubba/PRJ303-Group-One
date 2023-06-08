import Foundation
import FirebaseFirestore

struct Review: Identifiable {
    var id: String
    var review: String
    var sentiment: String
    var createdBy: String
    var createdAt: String
}
