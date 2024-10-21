import SwiftUI
import Combine

class InteractPookieViewModel: ObservableObject {
    private let cacheService = CacheDataManager()

    func userIsConnected() -> Bool {
        return cacheService.isUserConnected()
    }
    
}
