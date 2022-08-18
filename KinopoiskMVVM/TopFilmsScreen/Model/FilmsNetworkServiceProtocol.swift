
import Foundation

protocol FilmsNetworkServiceProtocol {
    
    func workingWithNetwork(completion: @escaping (Result<[Film], Error>) -> Void)
    
}
