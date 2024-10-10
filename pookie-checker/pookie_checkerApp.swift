import SwiftUI
import Firebase

var globalInstallationID: String = ""

@main
struct pookie_checkerApp: App {
    
    @State private var isButtonClicked: Bool
    
    init() {
        let didClickButton = UserDefaults.standard.bool(forKey: "logged")
        self.isButtonClicked = didClickButton
        
        FirebaseApp.configure()
        getFirebaseInstallationID { installationID in
            if let installationID {
                globalInstallationID = installationID
                print("Installation ID obtido: \(installationID)")
            } else {
                print("Erro ao obter Installation ID")
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            if isButtonClicked {
                HomeLoggedInView(viewModel: HomeLoggedInViewModel())
            } else {
                HomeView(viewModel: HomeViewModel())
                    .preferredColorScheme(.light)
            }
        }
    }
    
    func getFirebaseInstallationID(completion: @escaping (String?) -> Void) {
        Installations.installations().installationID { (installationID, error) in
            if let error = error {
                print("Erro ao obter o Installation ID: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let installationID = installationID {
                completion(installationID)
            }
        }
    }
}
