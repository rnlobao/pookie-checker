import SwiftUI

struct RootView: View {
    @ObservedObject var viewModel = RootViewModel()
    
    var body: some View {
        ZStack {
            if !viewModel.showSigninView {
                TabView {
                    ConnectPookieView()
                        .tabItem {
                            Label("Connection", systemImage: "app.connected.to.app.below.fill")
                        }
                    
                    InteractPookieView()
                        .tabItem {
                            Label("Interact", systemImage: "play.fill")
                        }
                    
                    SettingsView(showSignInView: $viewModel.showSigninView)
                        .tabItem {
                            Label("Settings", systemImage: "gearshape")
                        }
                }
            }
        }
        .onAppear {
            viewModel.checkAuthenticationStatus()
            viewModel.retrieveData()
        }
        .fullScreenCover(isPresented: $viewModel.showSigninView) {
            NavigationStack {
                AuthenticationView(showSignView: $viewModel.showSigninView)
            }
        }
    }
}
