import FirebaseFirestore
import FirebaseInstallations

class ConnectionService {
    private let db = Firestore.firestore()
    
    func generateConnection(pookieID: Int, completion: @escaping (String?, Error?) -> Void) {
        let code = UUID().uuidString.prefix(6).uppercased()
        let collection = self.db.collection("connections")
        
        collection.document(String(code)).getDocument { document, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let document = document, !document.exists {
                let data: [String: Any] = [
                    "user1Connected": true,
                    "user1ConnectedAt": FieldValue.serverTimestamp(),
                    "user1DeviceId": String(describing: globalInstallationID),
                    "user1PookieId": pookieID,
                    "user2Connected": false,
                    "user2ConnectedAt": NSNull(),
                    "user2DeviceId": NSNull()
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

    
    func connectToCode(code: String, completion: @escaping (Bool, Error?) -> Void) {
        let docRef = self.db.collection("connections").document(code)
        
        docRef.getDocument { document, error in
            if let error = error {
                completion(false, ConnectionError.firestoreError(description: error.localizedDescription))
                return
            }
            
            guard let document = document, document.exists else {
                completion(false, ConnectionError.firestoreError(description: "Código não encontrado"))
                return
            }
            
            if let data = document.data(),
               let user2Connected = data["user2Connected"] as? Bool {
                
                if !user2Connected {
                    docRef.updateData([
                        "user2Connected": true,
                        "user2DeviceId": String(describing: globalInstallationID),
                        "user2ConnectedAt": FieldValue.serverTimestamp()
                    ]) { error in
                        if let error = error {
                            completion(false, ConnectionError.firestoreError(description: error.localizedDescription))
                        } else {
                            completion(true, nil)
                        }
                    }
                } else {
                    completion(false, ConnectionError.firestoreError(description: "Alguém já se conectou a este código"))
                }
            }
        }
    }
    
    func listenForConnectionUpdates(code: String, completion: @escaping (Bool, Error?) -> Void) {
        let docRef = db.collection("connections").document(code)
        
        docRef.addSnapshotListener { documentSnapshot, error in
            if let error {
                completion(false, error)
                return
            }
            
            guard let document = documentSnapshot, document.exists else {
                completion(false, ConnectionError.firestoreError(description: "Documento não encontrado"))
                return
            }
            
            if let data = document.data(),
               let user1Connected = data["user1Connected"] as? Bool,
               let user2Connected = data["user2Connected"] as? Bool {
                if user1Connected && user2Connected {
                    completion(true, nil)
                } else {
                    completion(false, nil)
                }
            }
        }
    }
    
}
