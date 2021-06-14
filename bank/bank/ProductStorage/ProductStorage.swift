
import Foundation

protocol ProductStorage {
    
    func get(user: User) -> [Product]
    func add(user: User, product: Product)
}

class ProductStorageImpl: ProductStorage {

    
    let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    func get(user: User) -> [Product] {
        
        guard let productData = storage.get(key: "products_of_user_\(user.id)") else {
            return []
        }
        do {
            let products = try JSONDecoder().decode([Product].self, from: productData)
            return products
        } catch {
    
            print("JSONDecoder error \(error)")
    
            return []
    }
}
    
    func add(user: User, product: Product) {
        
        guard let productData = storage.get(key: "products_of_user_\(user.id)") else {
            let array = [product]
            
            do {
                let arrayData = try JSONEncoder().encode(array)
                storage.set(data: arrayData, key: "products_of_user_\(user.id)")
            } catch {
                print("JSONEncoder error \(error)")
            }
            
            return
        }
        
        do {
            var productArray = try JSONDecoder().decode([Product].self, from: productData)
            
            if let productIndex = productArray.firstIndex(where: { $0.id == product.id }) {
                productArray[productIndex] = product
            } else {
                productArray.append(product)
            }
            let arrayData = try JSONEncoder().encode(productArray)
            storage.set(data: arrayData, key: "products_of_user_\(user.id)")
        } catch {
            print("JSONEncoder error \(error)")
        }
    }
}
