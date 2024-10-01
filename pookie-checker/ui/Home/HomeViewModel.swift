import SwiftUI
import Combine
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    @Published var inputText: String = ""
    @Published var generatedCode: String? = nil
    @Published var selectedButtonIndex: Int? = nil
    @Published var isCodeGenerated: Bool = false
    @Published var showInput: Bool = false
    
    private let connectionService = ConnectionService()
    
    func generateCode() {
        connectionService.generateUniqueCode { [weak self] code, error in
            if let error {
                print("Erro ao gerar código: \(error.localizedDescription)")
                return
            }
            if let code {
                withAnimation {
                    self?.showInput = false
                    self?.isCodeGenerated = true
                    self?.generatedCode = code
                }
            }
        }
    }
    
    func showInputCodeField() {
        withAnimation {
            showInput = true
        }
    }
}
