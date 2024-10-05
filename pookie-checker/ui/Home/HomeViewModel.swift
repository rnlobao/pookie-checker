import SwiftUI
import Combine
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    @Published var inputText: String = ""
    @Published var generatedCode: String? = nil
    @Published var selectedButtonIndex: Int? = nil
    @Published var isCodeGenerated: Bool = false
    @Published var showInput: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: ErrorMessage? = nil
    @Published var connectionSuccessful: Bool = false // Nova propriedade para monitorar o status da conexão
    
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
                    self?.startListeningForConnectionUpdates()
                }
            }
        }
    }
    
    func showInputCodeField() {
        withAnimation {
            showInput = true
        }
    }
    
    func tryToConnect() {
        connectionService.connectToCode(code: inputText) { [weak self] success, error in
            DispatchQueue.main.async {
                if let error {
                    self?.errorMessage = ErrorMessage(message: error.localizedDescription)
                } else if success {
                    self?.connectionSuccessful = true
                }
            }
        }
    }
    
    func startListeningForConnectionUpdates() {
        connectionService.listenForConnectionUpdates(code: inputText) { [weak self] success, error in
            DispatchQueue.main.async {
                if let error {
                    self?.errorMessage = ErrorMessage(message: error.localizedDescription)
                } else if success {
                    self?.connectionSuccessful = true
                }
            }
        }
    }
    
}
