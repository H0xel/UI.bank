import Foundation
import Combine

typealias CurrencyCode = String

enum RatesServiceError: Error {
    case internalError
    case networkError(Error)
}

protocol RateService {
    func load(from: CurrencyCode, to: CurrencyCode) -> AnyPublisher<[CurrencyCode: Double], RatesServiceError>
}

class RateServiceImpl: RateService {
    
    func load(from: CurrencyCode, to: CurrencyCode) -> AnyPublisher<[CurrencyCode : Double], RatesServiceError> {
         
         let apiKey = "bf15dd8a3dc349b37477"
         
        /*
         "http://data.fixer.io/api/latest?access_key=02de8b96545720ea4708fdf181691252&base=\(base)")
         */
        
        guard let url = URL(string: "https://free.currconv.com/api/v7/convert?q=\(from)_\(to)&compact=ultra&apiKey=\(apiKey)") else {
                    return Future { $0(.failure(RatesServiceError.internalError)) }.eraseToAnyPublisher()
        }
        
        return URLSession
                    .shared
                    .dataTaskPublisher(for: url)
                    .tryMap { (data: Data, response: URLResponse) -> [CurrencyCode : Double] in
                        try JSONDecoder().decode([CurrencyCode : Double].self, from: data)
                    }
                    .mapError {
                        .networkError($0)
                    }
                .eraseToAnyPublisher()
    }
}

