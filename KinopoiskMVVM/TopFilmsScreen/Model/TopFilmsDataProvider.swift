
import Foundation
import UIKit

final class TopFilmsDataProvider {
    
    private let dataStorage: FilmsDataStorageProtocol
    private let networkService: FilmsNetworkServiceProtocol
    
    init(dataStorage: FilmsDataStorageProtocol = FilmsDataStorage.shared,
         networkService: FilmsNetworkServiceProtocol) {
        self.networkService = networkService
        self.dataStorage = dataStorage
    }
    
}

//MARK: TopFilmsDataProviding
extension TopFilmsDataProvider: TopFilmsDataProvidingProtocol {
    
    func gettingData(completion: @escaping ([Film]) -> Void) {
        networkService.workingWithNetwork { result in
            switch result {
            case .success(let model):
                completion(model)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getTheNumberOfFilms() -> Int {
        dataStorage.numberOfRowsInSection
    }
    
    func gettingFilmForCell(for indexPath: IndexPath) -> Film {
        dataStorage.getFilm(for: indexPath)
    }
    
}
