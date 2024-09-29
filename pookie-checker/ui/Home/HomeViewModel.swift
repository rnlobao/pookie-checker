import SwiftUI
import Combine
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    @Published var inputText: String = ""
    @Published var generatedCode: String? = nil
    @Published var showGeneratedCode: Bool = false
    @Published var selectedButtonIndex: Int? = nil
    @Published var isConnected: Bool = false
    @Published var isCodeGenerated: Bool = false
    
    private let connectionService = ConnectionService()
    
    func generateCode() {
        connectionService.generateUniqueCode { [weak self] code, error in
            if let error {
                print("Erro ao gerar código: \(error.localizedDescription)")
                return
            }
            if let code {
                self?.generatedCode = code
                withAnimation {
                    self?.isCodeGenerated = true
                }
                self?.showGeneratedCode = true
                self?.isConnected = true
            }
        }
    }
    
    func showInputCodeField() {
        withAnimation {
            self.isCodeGenerated = true
        }
    }
}
