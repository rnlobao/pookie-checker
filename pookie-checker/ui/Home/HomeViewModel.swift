import SwiftUI
import Combine
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    @Published var inputText: String = ""
    @Published var generatedCode: String? = nil
    
    // Validador para saber se um Pookie está selecionado
    @Published var currentUserPookieID: Int? = nil
    @Published var partnerPookieID: Int? = 2
    
    @Published var isCodeGenerated: Bool = false
    @Published var showInput: Bool = false
    @Published var connectionSuccessful: Bool = false
    
    @Published var errorMessage: ErrorMessage? = nil

    private let connectionService = ConnectionService()
    
    func generateCode() {
        guard let currentUserPookieID else { return }
        
        connectionService.generateConnection(pookieID: currentUserPookieID) { [weak self] code, error in
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
        guard let currentUserPookieID else { return }
        
        connectionService.connectToCode(code: inputText, pookieId: currentUserPookieID) { [weak self] response, error in
            DispatchQueue.main.async {
                if let error {
                    self?.errorMessage = ErrorMessage(message: error.localizedDescription)
                } else if response.success {
                    self?.connectionSuccessful = true
                    self?.partnerPookieID = response.pookieID
                }
            }
        }
    }
    
    func startListeningForConnectionUpdates(_ code: String) {
        connectionService.listenForConnectionUpdates(code: code) { [weak self] response, error in
            DispatchQueue.main.async {
                if let error {
                    self?.errorMessage = ErrorMessage(message: error.localizedDescription)
                } else if response.success {
                    self?.connectionSuccessful = true
                    self?.partnerPookieID = response.pookieID
                }
            }
        }
    }
    
    func canEnableStartButton() -> Bool {
        return connectionSuccessful
    }
    
    public func returnPookieImage() -> UIImage {
        let images = ["standing-dog", "standing-cat", "standing-panda", "standing-penguin"]
        switch partnerPookieID {
        case 0:
            return UIImage(named: images[0]) ?? UIImage()
        case 1:
            return UIImage(named: images[1]) ?? UIImage()
        case 2:
            return UIImage(named: images[2]) ?? UIImage()
        case 3:
            return UIImage(named: images[3]) ?? UIImage()
        default:
            return UIImage()
        }
    }
    
    public func returnPookieInteraction() -> UIImage {
        let images = ["kiss-dog", "kiss-cat", "kiss-panda", "kiss-penguin"]
        switch partnerPookieID {
        case 0:
            return UIImage(named: images[0]) ?? UIImage()
        case 1:
            return UIImage(named: images[1]) ?? UIImage()
        case 2:
            return UIImage(named: images[2]) ?? UIImage()
        case 3:
            return UIImage(named: images[3]) ?? UIImage()
        default:
            return UIImage()
        }
    }
}
