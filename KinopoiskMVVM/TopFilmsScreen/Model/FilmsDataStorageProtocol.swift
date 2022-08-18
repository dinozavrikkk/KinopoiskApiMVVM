
import Foundation

protocol FilmsDataStorageProtocol {
    
    func fillingFilmsWithData(data: Kino)
    var transmittingFilmsArray: [Film] { get }
    var numberOfRowsInSection: Int { get }
    func getFilm(for indexPath: IndexPath) -> Film
    
}
