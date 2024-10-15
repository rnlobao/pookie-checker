import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    
    init(user: User) {
        self.uid = user.uid
    }
}
