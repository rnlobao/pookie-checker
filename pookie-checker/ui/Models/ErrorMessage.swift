struct ErrorMessage: Identifiable {
    var id: String { message }
    let message: String
}

enum ConnectionError: Error {
    case installationIDNotFound
    case firestoreError(description: String)
    
    var localizedDescription: String {
        switch self {
        case .installationIDNotFound:
            return "Firebase Installation ID não foi encontrado."
        case .firestoreError(let description):
            return description
        }
    }
}
