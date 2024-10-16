import SwiftUI
import Combine

class GlobalState: ObservableObject {
    @Published var global_userIsConnected: Bool = false
    
    static let shared = GlobalState()
}
