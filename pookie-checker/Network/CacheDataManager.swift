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
}

