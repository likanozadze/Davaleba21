//
//  MovieItemCollectionViewCell.swift
//  21
//
//  Created by Lika Nozadze on 11/10/23.
//

import UIKit

class MovieItemCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"
    // MARK: - Properties
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .red
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        return button
    }()
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let id: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    
    private lazy var topButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var titleGenreStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, id])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview()
        setupConstraints()
        setupButtonAction()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
    // MARK: - CellLifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
        id.text = nil
        titleLabel.text = nil
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    // MARK: - Private Methods
    private func addSubview() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(topButtonStackView)
        contentView.addSubview(titleGenreStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 230)
        ])
        
        NSLayoutConstraint.activate([
            topButtonStackView.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 8),
            topButtonStackView.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: 8),
            topButtonStackView.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            titleGenreStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 8),
            titleGenreStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleGenreStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        
        let topRightButton = createTopButton()
        topButtonStackView.addArrangedSubview(favoriteButton)
        topButtonStackView.addArrangedSubview(topRightButton)
    }
    
    private func setupButtonAction() {
        favoriteButton.addAction(
            UIAction(
                title: "",
                handler: { [weak self] _ in
                    let isFavorite = self?.favoriteButton.currentImage == UIImage(systemName: "heart.fill")
                    self?.favoriteButton.setImage(UIImage(systemName: isFavorite ? "heart" : "heart.fill"), for: .normal)
                }
            ),
            for: .touchUpInside
        )
    }
    // MARK: - Helper Methods
    
    private func createTopButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    // MARK: - Configuration
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.posterImageView.image = image
                    }
                }
            }.resume()
        }
    }
}


