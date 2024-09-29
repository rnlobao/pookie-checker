import FirebaseFirestore

class ConnectionService {
    private let db = Firestore.firestore()
    
    func generateUniqueCode(completion: @escaping (String?, Error?) -> Void) {
        let code = UUID().uuidString.prefix(6).uppercased()
        
        let collection = db.collection("connections")
        
        collection.whereField("code", isEqualTo: code).getDocuments { snapshot, error in
            if let error = error {
                completion(nil, error) // Retorna o erro se houver
                return
            }
            
            if let snapshot = snapshot, snapshot.isEmpty {
                // Se o código não existe, salva o novo código no Firestore
                collection.addDocument(data: ["code": code]) { error in
                    if let error = error {
                        completion(nil, error)
                    } else {
                        completion(String(code), nil) // Retorna o código gerado
                    }
                }
            } else {
                // Caso o código já exista, tenta gerar um novo código
                self.generateUniqueCode(completion: completion)
            }
        }
    }
}
