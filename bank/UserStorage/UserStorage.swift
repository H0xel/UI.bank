
import Foundation

enum UserStorageError: Error {
    case decoding(Error)
    case encoding(Error)
    case userExists
    case userNotFound
}


protocol UserStorage {
    
    func users() -> [User]
    func add(user: User) throws
    func search(phone: Phone) throws -> User
    
}

class UserStorageImpl: UserStorage {
    
    let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    func search(phone: Phone) throws -> User {
        if let user = users().first(where: {$0.phone == phone}){
            return user
        } else {
            throw UserStorageError.userNotFound
        }
    }
    
    func users() -> [User] {
        do {
            let users: [User] = try storage.value(key: "clients")
            return users
        } catch {
            return []
        }
    }
    
    
    func add(user: User) throws {
        
       var users = self.users()
        if users.isEmpty {
            try storage.set(value: [user], key: "clients")
        } else {
            guard users.first(where: {$0.id == user.id }) == nil else { return }
            users.append(user)
            try storage.set(value: users, key: "clients")
        }
    }
}
