
import Foundation

final class TopFilmsViewModel {
    
    private let dataProvider: TopFilmsDataProvidingProtocol
    weak var delegate: TopFilmsControllerDelegate?
    
    init(dataProvider: TopFilmsDataProvidingProtocol) {
        self.dataProvider = dataProvider
    }
    
}

extension TopFilmsViewModel: TopFilmsDataPresentable {
    
    private func dataTransmission() {
        dataProvider.gettingData { [weak self] _ in
            self?.delegate?.fetchModel()
        }
    }
    
    func giveMeTheData() {
        dataTransmission()
    }
    
    func giveMeTheNewData() {
        dataTransmission()
    }
    
    var filmsCount: Int {
        dataProvider.getTheNumberOfFilms()
    }
    
    func film(for indexPath: IndexPath) -> Film {
        dataProvider.gettingFilmForCell(for: indexPath)
    }
    
}
