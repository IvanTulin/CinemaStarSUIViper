// ListFilmPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation
import SwiftUI

///
protocol ListFilmsPresenterProtocol: AnyObject {
    func fetchFilms()
    func didLoadFilm(films: [FilmsCommonInfo])
    // var isLoading: Bool { get set }
}

///
final class ListFilmsPresenter: ObservableObject {
    @Published private var interactor: ListFilmsInteractor?
    // @Published var isLoading = true

    var listFilmView: ListFilmsView?
    var filmsPublisher: AnyPublisher<[FilmsCommonInfo], Never> {
        filmsSubject.eraseToAnyPublisher()
    }

    private let filmsSubject = PassthroughSubject<[FilmsCommonInfo], Never>()
    private let router: ListFilmsRoutingProtocol
    private var cancellable: Set<AnyCancellable> = []

    init(interactor: ListFilmsInteractor, router: ListFilmsRoutingProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension ListFilmsPresenter: ListFilmsPresenterProtocol {
    func fetchFilms() {
        // isLoading = true
        interactor?.fetchFilms()
    }

    func didLoadFilm(films: [FilmsCommonInfo]) {
        filmsSubject.send(films)
    }

    func didSelectFilm(with filmId: Binding<String?>) {
        router.navigateToFilmDetails(withID: filmId)
    }
}
