// ListFilmsController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран Каталога фильмов
final class ListFilmsController: UIViewController {
    // MARK: - Constants

    enum Constants {
        static let textForTitleLabel = "Смотри исторические\nфильмы на CINEMA STAR"
        static let nameFont = "Inter"
        static let shimmerCellIdentifier = "shimmerCellIdentifier"
    }

    private var filmsNetwork: [FilmsCommonInfo]?
    // private let networkService = NetworkService()
    private let gradientsLayer = CAGradientLayer()

    // MARK: - Visual Components

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.textForTitleLabel
        label.font = UIFont(name: Constants.nameFont, size: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var collecctionView: UICollectionView = {
        let collecctionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
        collecctionView.backgroundColor = .clear
        collecctionView.dataSource = self
        collecctionView.delegate = self
        collecctionView.register(
            ShimmerCollectionViewCell.self,
            forCellWithReuseIdentifier: Constants.shimmerCellIdentifier
        )
        collecctionView.register(FilmCell.self, forCellWithReuseIdentifier: "FilmImageCell")
        collecctionView.translatesAutoresizingMaskIntoConstraints = false
        return collecctionView
    }()

    // MARK: - Private Properties

    private var viewModel: ListFilmViewModel?
    private var isLoading = true

    // MARK: - Initializers

    init(viewModels: ListFilmViewModel) {
        super.init(nibName: nil, bundle: nil)
        viewModel = viewModels
        viewModel?.updateView = { [weak self] state in
            guard let self = self else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                switch state {
                case let .success(films):
                    self.isLoading = false
                    self.filmsNetwork = films
                    self.collecctionView.reloadData()
                case .initial, .failure:
                    break
                case .loading:
                    break
                }
            }
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchFilms()
        setupGradient()
        configureUI()
        setupTitleLabelConstraits()
        configureCollecctionView()
    }

    // MARK: - Private Methods

    private func setupGradient() {
        view.layer.addSublayer(gradientsLayer)
        gradientsLayer.frame = view.bounds
        gradientsLayer.colors = [UIColor.cream.cgColor, UIColor.darkGreen.cgColor]
    }

    private func configureUI() {
        view.backgroundColor = .white
    }

    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 170, height: 260)
        layout.minimumLineSpacing = 17
        layout.minimumInteritemSpacing = 18
        layout.sectionInset = .init(top: 14, left: 16, bottom: 0, right: 16)
        return layout
    }

    private func setupTitleLabelConstraits() {
        view.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            titleLabel.widthAnchor.constraint(equalToConstant: 300),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func configureCollecctionView() {
        view.addSubview(collecctionView)

        NSLayoutConstraint.activate([
            collecctionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1),
            collecctionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collecctionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collecctionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - ListFilmsController + UICollectionViewDataSource

extension ListFilmsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        isLoading ? 6 : filmsNetwork?.count ?? 2
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if isLoading {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.shimmerCellIdentifier,
                for: indexPath
            ) as? ShimmerCollectionViewCell else { return UICollectionViewCell() }
            return cell
        } else {
            guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "FilmImageCell", for: indexPath) as? FilmCell
            else { return UICollectionViewCell() }
            guard let films = filmsNetwork else { return cell }
            cell.setupCell(filmsNetwork: films[indexPath.item])

            return cell
        }
    }
}

// MARK: - ListFilmsController + UICollectionViewDelegate

extension ListFilmsController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let id = filmsNetwork?[indexPath.item].id {
            viewModel?.transitionToDetailsFilm(id: id)
        }
    }
}
