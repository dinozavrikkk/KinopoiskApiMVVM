
import Foundation

protocol TopFilmsDataPresentable: AnyObject {
    var delegate: TopFilmsControllerDelegate? { get set }
    func giveMeTheData()
    func giveMeTheNewData()
    var filmsCount: Int { get }
    func film(for indexPath: IndexPath) -> Film
}
