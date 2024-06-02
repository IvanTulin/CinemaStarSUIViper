// MockPresenter2.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

class MockPresenter2: ListFilmsPresenterProtocol {
    @Published var films: [FilmsCommonInfo] = []
    @Published var error: Error?

    var didLoadFilmCalled = false
    var didFailWithErrorCalled = false

    func didLoadFilm(films: [FilmsCommonInfo]) {
        didLoadFilmCalled = true
        self.films = films
    }

    func didFailWithError(error: Error) {
        didFailWithErrorCalled = true
        self.error = error
    }

    func fetchFilms() {}
}
