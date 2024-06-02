// MockNetworkService.swift
// Copyright © RoadMap. All rights reserved.

@testable import CinemaStarMVVM
import Combine
import Foundation

class MockNetworkService: NetworkServiceProtocol2 {
    var fetchFilmsResult: Result<[FilmsCommonInfo], Error>?

    func fetchFilms() -> AnyPublisher<[FilmsCommonInfo], Error> {
        Future<[FilmsCommonInfo], Error> { promise in
            if let result = self.fetchFilmsResult {
                switch result {
                case let .success(films):
                    promise(.success(films))
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
