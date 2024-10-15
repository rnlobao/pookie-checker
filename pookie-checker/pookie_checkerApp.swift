import SwiftUI
import Firebase

import FirebaseCore
import FirebaseAuth
import GoogleSignIn

var userUID: String = ""

@main
struct pookie_checkerApp: App {
        
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .preferredColorScheme(.light)
        }
    }
}
