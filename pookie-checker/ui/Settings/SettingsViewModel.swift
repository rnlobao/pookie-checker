import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    func logOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}
