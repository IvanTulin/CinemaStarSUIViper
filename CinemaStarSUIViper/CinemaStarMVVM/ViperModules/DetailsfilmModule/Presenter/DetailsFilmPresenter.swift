// DetailsFilmPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation

/// Протокол для DetailsFilmPresenter
protocol DetailsFilmPresenterProtocol: AnyObject {
    func fetchDetailsFilm(id: String)
    func didLoadFilm(film: DetailsFilmCommonInfo)
}

/// Презентер для Детального экрана фильмов
final class DetailsFilmPresenter: ObservableObject {
    @Published private var interactor: DetailsFilmInteractor?

    var detailsFilmView: DetailsFilmView?
    var filmsPublisher: AnyPublisher<DetailsFilmCommonInfo, Never> {
        filmsSubject.eraseToAnyPublisher()
    }

    private var filmsSubject = PassthroughSubject<DetailsFilmCommonInfo, Never>()
    private let router: DetailsFilmRouterProtocol?

    init(interactor: DetailsFilmInteractor, router: DetailsFilmRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension DetailsFilmPresenter: DetailsFilmPresenterProtocol {
    func fetchDetailsFilm(id: String) {
        interactor?.fetchFilms(id: id)
    }

    func didLoadFilm(film: DetailsFilmCommonInfo) {
        filmsSubject.send(film)
    }

    func returnListFilm() {
        router?.navigateToListFilm()
    }
}
