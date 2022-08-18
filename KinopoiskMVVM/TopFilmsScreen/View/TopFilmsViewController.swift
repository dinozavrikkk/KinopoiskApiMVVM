
import UIKit

final class TopFilmsViewController: UIViewController {
    
    private let topFilmView = TopFilmsView()
    private let viewModel: TopFilmsDataPresentable
    
    init(viewModel: TopFilmsDataPresentable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = topFilmView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        customizationTableView()
        viewModel.giveMeTheData()
        updateNavBarTitle()
    }

}

//MARK: UITableViewDelegate, UITableViewDataSource
extension TopFilmsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filmsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TopFilmsTableViewCell", for: indexPath) as? TopFilmsTableViewCell
        else {
            return UITableViewCell()
        }
        cell.update(model: viewModel.film(for: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let numberOfCellsAtTheBottomOfTheTable = 5
        guard indexPath.item + numberOfCellsAtTheBottomOfTheTable >= viewModel.filmsCount else { return }
        viewModel.giveMeTheNewData()
    }
    
}

//MARK: TopFilmsControllerDelegate
extension TopFilmsViewController: TopFilmsControllerDelegate {
    
    func fetchModel() {
        topFilmView.tableView.reloadData()
    }

}

//MARK: CustomizeTableView
private extension TopFilmsViewController {
    
    func customizationTableView() {
        topFilmView.tableView.delegate = self
        topFilmView.tableView.dataSource = self
        topFilmView.tableView.register(TopFilmsTableViewCell.self, forCellReuseIdentifier: "TopFilmsTableViewCell")
        topFilmView.tableView.separatorStyle = .none
        topFilmView.tableView.rowHeight = UITableView.automaticDimension
    }
    
    func updateNavBarTitle() {
        title = "Топ 250 фильмов"
    }
    
}
