// FilmNetworkServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation

/// протокол для NetworkService
protocol FilmNetworkServiceProtocol {
    func fetchFilms() -> AnyPublisher<[FilmsCommonInfo], Error>
}

/// NetworkService
final class FilmNetworkService: FilmNetworkServiceProtocol {
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

    func fetchDetailsFilm(id: String) -> AnyPublisher<DetailsFilmCommonInfo, Error> {
        guard let urlRequest = requestCreator.createDetailsFilmRequest(id: id) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: DetailsFilmDTO.self, decoder: JSONDecoder())
            .map { DetailsFilmCommonInfo(dto: $0) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
