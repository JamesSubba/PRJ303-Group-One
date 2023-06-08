import SwiftUI
import Firebase

@main
struct PRJ303v4App: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
