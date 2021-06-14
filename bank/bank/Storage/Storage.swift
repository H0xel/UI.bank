import Foundation

protocol Storage {
    func set(data: Data, key: String)
    func get(key: String) -> Data?
}

class UserDef: Storage {
    
    var user = UserDefaults.standard
    
    func set(data: Data, key: String) {
        return user.setValue(data, forKey: key)
    }
    
    func get(key: String) -> Data? {
        return user.data(forKey: key)
    }
}


class FileManag: Storage {
    
    var filemanager = FileManager.default
    
    func set(data: Data, key: String) {
        filemanager.createFile(atPath: key, contents: data)
    }
    
    func get(key: String) -> Data? {
        return filemanager.contents(atPath: key)
    }
}

class InMemoryStorage: Storage {
    
    static let shared = InMemoryStorage()
    
    var dictionary: [String: Data] = [:]
    
    func set(data: Data, key: String) {
        dictionary[key] = data
    }
    
    func get(key: String) -> Data? {
        return dictionary[key]
    }
}


