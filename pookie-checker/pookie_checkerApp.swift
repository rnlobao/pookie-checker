import SwiftUI
import Firebase

var globalInstallationID: String = ""

@main
struct pookie_checkerApp: App {
    
    init() {
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
            HomeView(viewModel: HomeViewModel())
                .preferredColorScheme(.light)
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
