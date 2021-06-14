
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
        
        guard let usersData = storage.get(key: "clients") else {
            return []
        }
        
        do {
            let users = try JSONDecoder().decode([User].self, from: usersData)
            
            return users
            
        } catch {
            
            print("JSONDecoder error \(error)")
            
            return []
        }
    }
    
    func add(user: User) throws {
        
        guard let usersData = storage.get(key: "clients") else {
            let array = [user]
            
        do {
                
            let arrayData = try JSONEncoder().encode(array)
                storage.set(data: arrayData, key: "clients")
                
        } catch {
            throw UserStorageError.encoding(error)
            }
            return
        }
        
        do {
            var users = try JSONDecoder().decode([User].self, from: usersData)
            
            // убедиться, что юзера нету в этом массиве по идентификатору user.id
            
            if users.contains(where: {$0.id == user.id}) == false {
                users.append(user)
            }
            
            let usersData = try JSONEncoder().encode(users)
            storage.set(data: usersData, key: "clients")
            
        } catch {
            throw UserStorageError.decoding(error)
        }
    }
}
