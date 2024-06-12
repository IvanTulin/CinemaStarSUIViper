// MockInteractorTest.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import SwiftUI

class MockInteractorTest: ListFilmsInteractorProtocol, ObservableObject {
    weak var presenter: MockPresenterTest?
    @Published var films = [FilmsCommonInfo]()
    private var networkService = FilmNetworkService()
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
