// MockInteractor.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import SwiftUI

class MockInteractor: ListFilmsInteractorProtocol, ObservableObject {
    weak var presenter: MockPresenter?
    @Published var films = [FilmsCommonInfo]()
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
                guard let self = self else { return }
                self.films = film
                self.presenter?.films = film
            }
            .store(in: &cancellable)
    }
}
