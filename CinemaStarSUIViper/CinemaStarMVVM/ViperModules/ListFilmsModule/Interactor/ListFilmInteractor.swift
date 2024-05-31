// ListFilmInteractor.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation

// Interactor
protocol ListFilmsInteractorProtocol {
    func fetchFilms()
}

///
class ListFilmsInteractor: ListFilmsInteractorProtocol, ObservableObject {
    weak var presenter: ListFilmsPresenterProtocol?
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
//                    DispatchQueue.main.async {
//                        self.presenter?.isLoading = false // Данные загружены, останавливаем Шимер
//                    }
                    break
                }
            } receiveValue: { [weak self] film in
                self?.presenter?.didLoadFilm(films: film)
            }
            .store(in: &cancellable)
    }
}
