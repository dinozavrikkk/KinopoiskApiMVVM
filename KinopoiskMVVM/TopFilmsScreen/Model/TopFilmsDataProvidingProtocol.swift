
import Foundation
import UIKit

protocol TopFilmsDataProvidingProtocol {
    func gettingData(completion: @escaping ([Film]) -> Void)
    func getTheNumberOfFilms() -> Int
    func gettingFilmForCell(for indexPath: IndexPath) -> Film
}
