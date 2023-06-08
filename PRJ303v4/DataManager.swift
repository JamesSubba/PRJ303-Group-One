import Foundation
import SwiftUI
import Firebase

struct DBUser {
    let userId: String
    let username: String
}

class DataManager: ObservableObject {
    static let shared = DataManager()
    private init(){
    }
    func fetchUserInfo(userID: String) async throws -> DBUser {
        let snapshot = try await Firestore.firestore().collection("users").document(userID).getDocument()
        guard let data = snapshot.data(), let userId = data["uid"] as? String , let username = data["fullname"] as? String else {
            throw URLError(.badServerResponse)
        }
        return DBUser(userId: userId, username: username)
    }
}
