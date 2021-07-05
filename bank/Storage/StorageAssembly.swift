//
//  StorageAssembly.swift
//  bank
//
//  Created by Ivan Amakhin on 03.05.2021.
//

import Foundation

class StoragesAssembly {
    
    var inMemory: Storage {
        return InMemoryStorage.shared
        }

    var userDefaults: Storage {
            return UserDef()
        }
    
    var filesystemStorage: Storage {
            return FileManag()
        }
    
    var userStorage: UserStorage {
        return UserStorageImpl(storage: inMemory)
    }
    
    var productStorage: ProductStorage {
        return ProductStorageImpl(storage: inMemory)
    }
}




