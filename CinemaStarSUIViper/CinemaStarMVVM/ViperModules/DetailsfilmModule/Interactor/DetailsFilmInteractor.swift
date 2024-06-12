// DetailsFilmInteractor.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation

///
protocol DetailsFilmInteractorProtocol {
    func fetchFilms(id: String)
}

///
final class DetailsFilmInteractor: ObservableObject {
    weak var presenter: DetailsFilmPresenter?
    private var networkService = FilmNetworkService()
    private var cancellable: Set<AnyCancellable> = []
}

extension DetailsFilmInteractor: DetailsFilmInteractorProtocol {
    func fetchFilms(id: String) {
        networkService.fetchDetailsFilm(id: id)
            .sink { completion in
                switch completion {
                case let .failure(error):
                    // Обработка ошибок, возможно уведомление Presenter
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] film in
                self?.presenter?.didLoadFilm(film: film)
            }
            .store(in: &cancellable)
    }
}
