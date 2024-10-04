import FirebaseFirestore
import FirebaseInstallations

class ConnectionService {
    private let db = Firestore.firestore()
    
    func generateUniqueCode(completion: @escaping (String?, Error?) -> Void) {
        getFirebaseInstallationID { [weak self] installationID in
            guard let installationID, let self else {
                completion(nil, ConnectionError.installationIDNotFound)
                return
            }
            
            let code = UUID().uuidString.prefix(6).uppercased()
            let collection = self.db.collection("connections")
            
            collection.whereField("code", isEqualTo: code).getDocuments { snapshot, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                if let snapshot = snapshot, snapshot.isEmpty {
                    // Adicionando o código com os campos de usuário e identificadores de dispositivo
                    let data: [String: Any] = [
                        "code": code,
                        "user1Connected": true,
                        "user1ConnectedAt": FieldValue.serverTimestamp(),
                        "user1DeviceId": installationID, // Usando o FID como identificador do dispositivo do primeiro usuário
                        "user2Connected": false,
                        "user2ConnectedAt": NSNull(), // Inicializado como null até o segundo usuário se conectar
                        "user2DeviceId": NSNull() // Inicializado como null até o segundo usuário se conectar
                    ]
                    
                    collection.addDocument(data: data) { error in
                        if let error = error {
                            completion(nil, error)
                        } else {
                            completion(String(code), nil)
                        }
                    }
                } else {
                    self.generateUniqueCode(completion: completion)
                }
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
