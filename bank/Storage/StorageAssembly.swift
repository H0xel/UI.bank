import Foundation
import EasyDi

class StoragesAssembly: Assembly {
    var inMemory: Storage {
        return define(scope: .lazySingleton, init: InMemoryStorage())
    }
    
    var userDefaults: Storage {
            return define(init: UserDef())
        }
    
    var filesystemStorage: Storage {
            return define(init: FileManag())
        }
    
    var userStorage: UserStorage {
        return define(init: UserStorageImpl(storage: self.inMemory))
    }
    
    var productStorage: ProductStorage {
        return define(init: ProductStorageImpl(storage: self.inMemory))
    
    }
}

