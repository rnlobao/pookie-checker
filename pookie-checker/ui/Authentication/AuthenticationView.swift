import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct AuthenticationView: View {
    
    @StateObject private var viewModel = AuthenticationViewModel()
    @Binding var showSignView: Bool
    
    var body: some View {
        VStack {
            GoogleSignInButton(
                viewModel: GoogleSignInButtonViewModel(
                    scheme: .dark,
                    style: .wide,
                    state: .normal
                )) {
                    Task {
                        do {
                            try await viewModel.signInGoogle()
                            showSignView = false
                        } catch {
                            print(error)
                        }
                    }
                }
        }
    }
    
}
