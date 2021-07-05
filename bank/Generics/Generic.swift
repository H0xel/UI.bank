import Foundation

enum PrintDataError: Error {
    case printingError
}

func printData<T: Codable>(key: String, type: T.Type) throws {
    let value: T = try assembly.storagesAssembly.inMemory.value(key: key)
    print(value)
}
