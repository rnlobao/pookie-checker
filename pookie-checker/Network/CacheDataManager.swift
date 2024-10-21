import Foundation

struct CacheDataManager {
    func saveUserCodeConnection(_ code: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(code, forKey: "codigoFirebase")
    }

    func clearUserCodeConnection() {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "codigoFirebase")
    }
    
    func getUserCodeConnection() -> String? {
        let userDefaults = UserDefaults.standard
        return userDefaults.string(forKey: "codigoFirebase")
    }
    
    func isUserConnected() -> Bool {
        let userDefaults = UserDefaults.standard
        if let savedUserCode = userDefaults.string(forKey: "codigoFirebase"), !savedUserCode.isEmpty {
            return true
        } else {
            return false
        }
    }
}

