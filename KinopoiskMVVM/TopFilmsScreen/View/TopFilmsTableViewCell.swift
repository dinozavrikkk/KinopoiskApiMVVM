
import UIKit
import Kingfisher

final class TopFilmsTableViewCell: UITableViewCell {
    
    private let conteinerForFilmView: UIView = {
       let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let filmImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let filmNameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let yearOfReleaseFilmLabel: UILabel = {
        let label = UILabel()
         label.textColor = .white
         label.font = .systemFont(ofSize: 14)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let genreFilmLabel: UILabel = {
       let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        [filmNameLabel, yearOfReleaseFilmLabel, genreFilmLabel].forEach { stack.addArrangedSubview($0) }
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let filmRatingLabel: UILabel = {
       let label = UILabel()
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let filmCountriesLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        selectionStyle = .none
        
        addSubvies()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubvies() {
        [conteinerForFilmView, filmImageView, verticalStack, filmRatingLabel, filmCountriesLabel].forEach { subview in contentView.addSubview(subview) }
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            conteinerForFilmView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            conteinerForFilmView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            conteinerForFilmView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            conteinerForFilmView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            conteinerForFilmView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            filmImageView.topAnchor.constraint(equalTo: conteinerForFilmView.topAnchor, constant: 6),
            filmImageView.leadingAnchor.constraint(equalTo: conteinerForFilmView.leadingAnchor, constant: 6),
            filmImageView.bottomAnchor.constraint(equalTo: conteinerForFilmView.bottomAnchor, constant: -6),
            filmImageView.widthAnchor.constraint(equalToConstant: 90)
        ])
        
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: conteinerForFilmView.topAnchor, constant: 12),
            verticalStack.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 12),
            verticalStack.trailingAnchor.constraint(equalTo: conteinerForFilmView.trailingAnchor, constant: -12),
            verticalStack.heightAnchor.constraint(equalToConstant: 55)
        ])
        
        NSLayoutConstraint.activate([
            filmRatingLabel.topAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: 12),
            filmRatingLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 12),
            filmRatingLabel.bottomAnchor.constraint(equalTo: conteinerForFilmView.bottomAnchor, constant: -12),
            filmRatingLabel.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            filmCountriesLabel.topAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: 12),
            filmCountriesLabel.leadingAnchor.constraint(equalTo: filmRatingLabel.trailingAnchor, constant: 12),
            filmCountriesLabel.trailingAnchor.constraint(equalTo: conteinerForFilmView.trailingAnchor, constant: -12),
            filmCountriesLabel.bottomAnchor.constraint(equalTo: conteinerForFilmView.bottomAnchor, constant: -12)
        ])
        
    }
    
    func update(model: Film) {
        
        filmNameLabel.text = model.nameRu
        yearOfReleaseFilmLabel.text = model.year
        
        guard let validRating = Double(model.rating) else { return }
        switch validRating {
        case 0...4.9: filmRatingLabel.textColor = .systemRed
        case 5.0...6.9: filmRatingLabel.textColor = .systemGray
        case 7.0...10: filmRatingLabel.textColor = .systemGreen
        default: break
        }
        filmRatingLabel.text = model.rating
        
        if model.countries.count > 1 {
            filmCountriesLabel.text = "\(model.countries.map({"\($0.country)" }).joined(separator: ", ")) \(model.filmLength)"
        } else {
            filmCountriesLabel.text = "\(model.countries[0].country) \(model.filmLength)"
        }
        
        if model.genres.count > 1 {
            genreFilmLabel.text = model.genres.map({"\($0.genre)" }).joined(separator: ", ")
        } else {
            genreFilmLabel.text = model.genres[0].genre
        }
        
        guard let urlImage = URL(string: model.posterURLPreview) else { return }
        filmImageView.kf.setImage(with: urlImage)
        
    }
    
}
