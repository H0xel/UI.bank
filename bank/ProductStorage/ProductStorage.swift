
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
    
    func get(user: User) -> [Product]  {
        do {
            let products: [Product] = try storage.value(key: "products_of_user_\(user.id)")
            return products
        } catch {
            return []
        }
    }
    func add(user: User, product: Product) {
        var products = get(user: user)
        if products.isEmpty {
            do {
                try storage.set(value: [product], key: "products_of_user_\(user.id)")
            } catch {
                print("Error saving product")
            }
        } else {
            if let productIndex = products.firstIndex(where: { $0.id == product.id }) {
                products[productIndex] = product
            } else {
                products.append(product)
            }
            do {
                try storage.set(value: products, key: "products_of_user_\(user.id)")
            } catch {
                print("Error saving product")
            }
        }
    }
}
