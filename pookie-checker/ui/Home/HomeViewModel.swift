import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var heartCount: Int = 2  // Defina o valor inicial que você quiser
    
    // Você pode definir o valor ou atualizar a lógica de acordo com seu caso de uso
    func setHeartCount(_ count: Int) {
        heartCount = count
    }
}
