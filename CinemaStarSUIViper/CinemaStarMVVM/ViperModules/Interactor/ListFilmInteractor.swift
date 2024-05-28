// ListFilmInteractor.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation

// Interactor
protocol ListFilmsInteractorInput {
    func fetchFilms()
}

class ListFilmsInteractor: ListFilmsInteractorInput, ObservableObject {
    @Published var films: [FilmsCommonInfo] = []

    weak var presenter: ListFilmsInteractorOutput?
    private var networkService = NetworkService2()
    private var cancellable: Set<AnyCancellable> = []

    func fetchFilms() {
        networkService.fetchFilms()
            .sink { completion in
                switch completion {
                case let .failure(error):
                    // Обработка ошибок, возможно уведомление Presenter
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] film in
                self?.films = film
            }
            .store(in: &cancellable)
    }
}
