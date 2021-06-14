import Foundation

struct ProductPreferences: Codable {
    let productReceiverID: String
    let productSenderID: String
}


protocol PreferencesService {
    func getPreferences(user: User) -> ProductPreferences?
    func set(preferences: ProductPreferences, user: User)
}

class PreferencesServiceImpl: PreferencesService {
    var storage = StoragesAssembly().inMemory
    
    func set(preferences: ProductPreferences, user: User) {
        do {
            let preferencesData = try JSONEncoder().encode(preferences)
            storage.set(data: preferencesData, key: "preferences_id_\(user.id)")
        } catch {
            print("JSONEncoder error \(error)")
        }
    }
    
    func getPreferences(user: User) -> ProductPreferences? {
        guard let preferencesData = storage.get(key: "preferences_id_\(user.id)") else {
            return nil
        }
        do {
            let preferences = try JSONDecoder().decode(ProductPreferences.self, from: preferencesData)
            return preferences
        } catch {
            print("JSONDecoder error \(error)")
            return nil
        }
    }
    

}
