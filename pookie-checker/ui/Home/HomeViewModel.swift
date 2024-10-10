import SwiftUI
import Combine
import FirebaseFirestore
import GoogleSignIn

class HomeViewModel: ObservableObject {
    @Published var inputText: String = ""
    @Published var generatedCode: String? = nil
    @Published var connectedCode: String? = nil
    
    @Published var userPookieID: Int? = nil
    @Published var partnerPookieID: Int? = 2
    
    @Published var isCodeGenerated: Bool = false
    @Published var showInput: Bool = false
    @Published var connectionSuccessful: Bool = false
    
    @Published var errorMessage: ErrorMessage? = nil

    private let connectionService = ConnectionService()
    private let bundle = Bundle(for: HomeViewModel.self)
    
    func generateCode() {
        guard let userPookieID else { return }
        
        connectionService.generateConnection(pookieID: userPookieID) { [weak self] code, error in
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
        guard let userPookieID else { return }
        
        connectionService.connectToCode(code: inputText, pookieId: userPookieID) { [weak self] response, error in
            DispatchQueue.main.async {
                if let error {
                    self?.errorMessage = ErrorMessage(message: error.localizedDescription)
                } else if response.success {
                    self?.connectionSuccessful = true
                    self?.partnerPookieID = response.pookieID
                    self?.connectedCode = self?.inputText
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
        guard let partnerPookieID else { return UIImage() }
        let images = ["standing-dog", "standing-cat", "standing-panda", "standing-penguin"]
        return UIImage(named: images[partnerPookieID]) ?? UIImage()
    }
    
    public func returnPookieInteraction() -> UIImage {
        guard let partnerPookieID else { return UIImage() }
        let images = ["kiss-dog", "kiss-cat", "kiss-panda", "kiss-penguin"]
        return UIImage(named: images[partnerPookieID]) ?? UIImage()
    }
    
    public func savePookiesInfo() {
        UserDefaults.standard.set(true, forKey: "logged")
        if let connectedCode {
            UserDefaults.standard.set(connectedCode, forKey: "code")
        } else if let generatedCode {
            UserDefaults.standard.set(generatedCode, forKey: "code")
        }
    }
}
