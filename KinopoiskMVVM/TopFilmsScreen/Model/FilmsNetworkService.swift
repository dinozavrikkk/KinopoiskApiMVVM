
import Foundation

final class FilmsNetworkService {

    private let queue = DispatchQueue(label: "com.TopFilmsDataProvider.URLSession", qos: .userInteractive, attributes: .concurrent)
    private var currentPage: Int = 1
    private let dataStorage: FilmsDataStorageProtocol
    
    init(dataStorage: FilmsDataStorageProtocol = FilmsDataStorage.shared) {
        self.dataStorage = dataStorage
    }

}

//MARK: FilmsNetworkServiceProtocol
extension FilmsNetworkService: FilmsNetworkServiceProtocol {
   
    func workingWithNetwork(completion: @escaping (Result<[Film], Error>) -> Void) {
        queue.async { [weak self] in
            guard let self = self else { return }
            guard let url = URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?page=\(self.currentPage)") else { return }
            
            self.currentPage += 1
            var request = URLRequest(url: url)
            request.setValue("c3b53a94-80d5-41b3-a667-2424d1bfd9ad", forHTTPHeaderField: "X-API-KEY")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data, let topFilms = try? JSONDecoder().decode(Kino.self, from: data) {
                    DispatchQueue.main.async {
                        self.dataStorage.fillingFilmsWithData(data: topFilms)
                        completion(.success(self.dataStorage.transmittingFilmsArray))
                    }
                } else {
                    self.currentPage -= 1
                    guard let error = error else { return }
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    }
    
}
