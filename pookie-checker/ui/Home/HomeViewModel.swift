import SwiftUI
import Combine
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    @Published var inputText: String = ""
    @Published var generatedCode: String? = nil
    
    // Validador para saber se um Pookie está selecionado
    @Published var selectedButtonIndex: Int? = nil
    @Published var isCodeGenerated: Bool = false
    @Published var showInput: Bool = false
    @Published var connectionSuccessful: Bool = false
    
    @Published var errorMessage: ErrorMessage? = nil

    
    private let connectionService = ConnectionService()
    
    func generateCode() {
        guard let selectedButtonIndex else { return }
        
        connectionService.generateConnection(pookieID: selectedButtonIndex) { [weak self] code, error in
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
                self?.startListeningForConnectionUpdates(code)
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
    
    func startListeningForConnectionUpdates(_ code: String) {
        connectionService.listenForConnectionUpdates(code: code) { [weak self] success, error in
            DispatchQueue.main.async {
                if let error {
                    self?.errorMessage = ErrorMessage(message: error.localizedDescription)
                } else if success {
                    self?.connectionSuccessful = true
                }
            }
        }
    }
    
    func canEnableStartButton() -> Bool {
        return connectionSuccessful
    }
    
}
