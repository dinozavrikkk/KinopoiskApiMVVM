
import Foundation
import UIKit

enum ModuleBuilder {
    
    static func assemblyMainController() -> UIViewController {
        let networkService = FilmsNetworkService()
        let dataProvider = TopFilmsDataProvider(networkService: networkService)
        let viewModel = TopFilmsViewModel(dataProvider: dataProvider)
        let viewController = TopFilmsViewController(viewModel: viewModel)
        return viewController
    }
    
}
