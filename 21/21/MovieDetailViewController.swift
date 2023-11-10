//
//  MovieDetailViewController.swift
//  21
//
//  Created by Lika Nozadze on 11/10/23.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    // MARK: - UI Components
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 210).isActive = true
        return imageView
    }()

    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let bottomSectionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = UIColor(red: 31/255.0, green: 41/255.0, blue: 61/255.0, alpha: 1)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return stackView
    }()
    
    private let selectSessionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select session", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 8
        button.heightAnchor.constraint(equalToConstant: 56).isActive = true
        return button
    }()
    
    private var movie: Movie?
    
    // MARK: - ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    // MARK: - Private Methods
    private func setup() {
        view.backgroundColor = UIColor(red: 26/255.0, green: 34/255.0, blue: 50/255.0, alpha: 1)
        setupMainStackView()
        setupMovieRatingInformation()
        setupDescriptionLabel()
        setupBottomSectionStackView()
        setupSelectSessionButton()
        setupMovieWithInformation()
        setupMovieWithInformation()
    }
    
    private func setupMainStackView() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(posterImageView)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func setupMovieRatingInformation() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.backgroundColor = UIColor(red: 99/255.0, green: 115/255.0, blue: 148/255.0, alpha: 0.1)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        
        stackView.addArrangedSubview(ratingLabel)

        
        mainStackView.addArrangedSubview(stackView)
    }
    
    private func setupDescriptionLabel() {
        let stackView = UIStackView()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 12, right: 16)
        
        stackView.addArrangedSubview(overviewLabel)
        mainStackView.addArrangedSubview(stackView)
    }
        
    private func createInfoStackView(_ title: String, detail: String) {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.alignment = .leading
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 12, right: 16)
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.widthAnchor.constraint(equalToConstant: 86).isActive = true
        
        let detailLabel = UILabel()
        detailLabel.text = detail
        detailLabel.textColor = .white
        detailLabel.numberOfLines = 0
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(detailLabel)
        
        mainStackView.addArrangedSubview(stackView)
    }
    
    private func setupBottomSectionStackView() {
        view.addSubview(bottomSectionStackView)
    
        NSLayoutConstraint.activate([
            bottomSectionStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSectionStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSectionStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomSectionStackView.heightAnchor.constraint(equalToConstant: 114)
        ])
    }
    
    private func setupSelectSessionButton() {
        bottomSectionStackView.addArrangedSubview(selectSessionButton)
    }

    private func setupMovieWithInformation() {
          guard let movie = self.movie else { return }
          navigationItem.title = movie.title
          ratingLabel.text = "Vote Average: \(movie.voteAverage)"
          overviewLabel.text = movie.overview
    
      }
    
    
    // MARK: - Configure
    func configure(with movie: Movie) {
        self.movie = movie
    }
}
