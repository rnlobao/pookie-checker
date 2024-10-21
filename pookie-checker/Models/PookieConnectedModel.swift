import FirebaseFirestore

struct PookieConnectedModel {
    var user1Connected: Bool
    var user1Id: String
    var user1PookieId: Int
    
    var user2Connected: Bool
    var user2Id: String
    var user2PookieId: Int
    
    init?(from document: DocumentSnapshot) {
        let data = document.data()
        
        guard
            let user1Connected = data?["user1Connected"] as? Bool,
            let user1Id = data?["user1Id"] as? String,
            let user1PookieId = data?["user1PookieId"] as? Int,
            let user2Connected = data?["user2Connected"] as? Bool,
            let user2Id = data?["user2Id"] as? String,
            let user2PookieId = data?["user2PookieId"] as? Int
        else {
            return nil
        }

        self.user1Connected = user1Connected
        self.user1Id = user1Id
        self.user1PookieId = user1PookieId
        self.user2Connected = user2Connected
        self.user2Id = user2Id
        self.user2PookieId = user2PookieId
    }
}
