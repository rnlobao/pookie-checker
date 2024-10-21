import SwiftUI
import Combine

class RootViewModel: ObservableObject {
    private let connectionService = ConnectionService()
    @Published var showSigninView = false

    func checkAuthenticationStatus() {
        let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
        self.showSigninView = authUser == nil
        gloabl_userUID = authUser?.uid ?? ""
    }
    
    func retrieveData() {
        connectionService.attemptFirebaseConnection()
    }
}
