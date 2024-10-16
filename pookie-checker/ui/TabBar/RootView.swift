import SwiftUI

struct RootView: View {
    @State private var showSigninView = false
    
    var body: some View {
        ZStack {
            if !showSigninView {
                
                TabView {
                    ConnectPookieView()
                        .tabItem {
                            Label("Connection", systemImage: "app.connected.to.app.below.fill")
                        }
                    
                    InteractPookieView()
                        .tabItem {
                            Label("Interact", systemImage: "play.fill")
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
        gloabl_userUID = authUser?.uid ?? ""
    }
}
