import SwiftUI
import Combine

class GlobalState: ObservableObject {
    @Published var global_userIsConnected: Bool = false
    @Published var global_currentPookieConnection: PookieConnectedModel?
    
    static let shared = GlobalState()
}
