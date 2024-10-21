import FirebaseFirestore
import FirebaseInstallations

class ConnectionService {
    private let db = Firestore.firestore()
    private let localStorage = CacheDataManager()
    
    func generateConnection(pookieID: Int, completion: @escaping (String?, Error?) -> Void) {
        let code = UUID().uuidString.prefix(6).uppercased()
        let collection = self.db.collection("connections")
        
        collection.document(String(code)).getDocument { document, error in
            if let error {
                completion(nil, error)
                return
            }
            
            if let document, !document.exists, !gloabl_userUID.isEmpty {
                let data: [String: Any] = [
                    "user1Connected": true,
                    "user1Id": gloabl_userUID,
                    "user1PookieId": pookieID,
                    "user2Connected": false,
                    "user2Id": NSNull(),
                    "user2PookieId": pookieID,
                ]
                
                collection.document(String(code)).setData(data) { error in
                    if let error = error {
                        completion(nil, error)
                    } else {
                        completion(String(code), nil)
                    }
                }
            } else {
                self.generateConnection(pookieID: pookieID, completion: completion)
            }
        }
    }
    
    
    func connectToCode(code: String, pookieId: Int, completion: @escaping (PookieModel, Error?) -> Void) {
        let docRef = self.db.collection("connections").document(code)
        
        docRef.getDocument {
            document,
            error in
            if let error {
                completion(PookieModel(success: false), ConnectionError.firestoreError(description: error.localizedDescription))
                return
            }
            
            guard let document,
                  document.exists else {
                completion(
                    PookieModel(success: false),
                    ConnectionError.firestoreError(description: "Código não encontrado")
                )
                return
            }
            
            if let data = document.data(),
               let user2Connected = data["user2Connected"] as? Bool,
               let user1PookieID = data["user2PookieId"] as? Int {
                
                if !user2Connected {
                    docRef.updateData([
                        "user2Connected": true,
                        "user2Id": gloabl_userUID,
                        "user2PookieId": pookieId
                    ]) { [weak self] error in
                        if let error {
                            completion(
                                PookieModel(success: false),
                                ConnectionError.firestoreError(description: error.localizedDescription)
                            )
                        } else {
                            completion(
                                PookieModel(success: true, pookieID: user1PookieID),
                                nil
                            )
                        }
                    }
                } else {
                    completion(
                        PookieModel(
                            success: false
                        ),
                        ConnectionError.firestoreError(description: "Alguém já se conectou a este código")
                    )
                }
            }
        }
    }
    
    func listenForConnectionUpdates(code: String, completion: @escaping (PookieModel, Error?) -> Void) {
        let docRef = db.collection("connections").document(code)
        
        docRef.addSnapshotListener { [weak self] documentSnapshot, error in
            if let error {
                completion(PookieModel(success: false), error)
                return
            }
            
            guard let document = documentSnapshot, document.exists else {
                completion(
                    PookieModel(success: false),
                    ConnectionError.firestoreError(description: "Documento não encontrado")
                )
                return
            }
            
            if let data = document.data(),
               let user1Connected = data["user1Connected"] as? Bool,
               let user2Connected = data["user2Connected"] as? Bool,
               let user2PookieID = data["user2PookieId"] as? Int {
                if user1Connected && user2Connected {
                    completion(PookieModel(success: true, pookieID: user2PookieID), nil)
                } else {
                    completion(PookieModel(success: false), nil)
                }
            }
        }
    }
    
    func clearCacheConnection() {
        localStorage.clearUserCodeConnection()
    }
    
}

extension ConnectionService {
    func attemptFirebaseConnection() {
        if let savedUserCode = localStorage.getUserCodeConnection() {
            print("Tentando buscar documento com código salvo: \(savedUserCode)")
            
            let docRef = db.collection("connections").document(savedUserCode)
            
            docRef.getDocument { (document, error) in
                if let error = error {
                    print("Erro ao tentar buscar documento: \(error.localizedDescription)")
                    return
                }
                
                if let document, document.exists {
                    if let pookieModel = PookieConnectedModel(from: document) {
                    } else {
                        print("Falha ao criar o modelo a partir do documento.")
                    }
                } else {
                    print("Nenhum documento encontrado com esse código.")
                }
            }
        } else {
            print("Nenhum código salvo no cache. Direcionando para tela de login.")
        }
    }
    
}
