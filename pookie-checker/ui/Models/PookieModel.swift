struct PookieModel {
    let success: Bool
    let pookieID: Int
    
    public init(success: Bool, pookieID: Int = 5) {
        self.success = success
        self.pookieID = pookieID
    }
}
