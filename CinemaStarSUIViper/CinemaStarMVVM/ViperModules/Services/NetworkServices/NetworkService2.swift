// NetworkService2.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation

///
protocol NetworkServiceProtocol2 {
    func fetchFilms() -> AnyPublisher<[FilmsCommonInfo], Error>
}

/// NetworkService
final class NetworkService2: NetworkServiceProtocol2 {
    private var requestCreator = RequestCreator()

    func fetchFilms() -> AnyPublisher<[FilmsCommonInfo], Error> {
        guard let urlRequest = requestCreator.createFilmRequest() else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: CinemaStarDTO.self, decoder: JSONDecoder())
            .map { $0.docs.map { FilmsCommonInfo(dto: $0) } }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
