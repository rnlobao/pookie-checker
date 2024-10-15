import SwiftUI

struct RootView: View {
    @State private var showSigninView = false
    
    var body: some View {
        ZStack {
            if !showSigninView {
                TabView {
                    ConnectPookieView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                    
                    SettingsView(showSignInView: $showSigninView)
                        .tabItem {
                            Label("Settings", systemImage: "gearshape")
                        }
                }
            }
        }
        .onAppear {
            checkAuthenticationStatus()
        }
        .fullScreenCover(isPresented: $showSigninView) {
            NavigationStack {
                AuthenticationView(showSignView: $showSigninView)
            }
        }
    }
    
    private func checkAuthenticationStatus() {
        let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
        self.showSigninView = authUser == nil
        userUID = authUser?.uid ?? ""
    }
}
