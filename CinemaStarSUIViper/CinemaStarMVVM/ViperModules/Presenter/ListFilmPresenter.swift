// ListFilmPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation
import SwiftUI

///
protocol ListFilmsPresenterProtocol: AnyObject {
    func fetchFilms()
    func didLoadFilm(films: [FilmsCommonInfo])
}

///
final class ListFilmsPresenter: ObservableObject {
    @Published private var interactor: ListFilmsInteractor?
//    @Published var selectedFilmId: String?
//    @Published var isShowDetailView = false

    private let filmsSubject = PassthroughSubject<[FilmsCommonInfo], Never>()

    var filmsPublisher: AnyPublisher<[FilmsCommonInfo], Never> {
        filmsSubject.eraseToAnyPublisher()
    }

    var listFilmView: ListFilmsView?

    private let router: ListFilmsRoutingProtocol
    private var cancellable: Set<AnyCancellable> = []

    init(interactor: ListFilmsInteractor, router: ListFilmsRoutingProtocol) {
        self.router = router
        self.interactor = interactor
    }

//    func showDetailsView(id: String) {
//        selectedFilmId = id
//        isShowDetailView = true
//    }
}

extension ListFilmsPresenter: ListFilmsPresenterProtocol {
    func fetchFilms() {
        interactor?.fetchFilms()
    }

    func didLoadFilm(films: [FilmsCommonInfo]) {
        filmsSubject.send(films)
    }

    func didSelectFilm(with filmId: Binding<String?>) {
        router.navigateToFilmDetails(withID: filmId)
    }
}
