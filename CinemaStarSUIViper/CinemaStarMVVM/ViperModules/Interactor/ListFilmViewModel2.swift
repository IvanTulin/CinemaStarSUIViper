// ListFilmViewModel2.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation

// swiftlint:disable all
final class ListFilmViewModel2: ObservableObject {
    @Published var films: [FilmsCommonInfo] = []

    private var requestCreator = RequestCreator()
    private var cancellable: Set<AnyCancellable> = []

    func fetch() {
        guard let urlRequesr = requestCreator.createFilmRequest() else { return }
        URLSession.shared.dataTaskPublisher(for: urlRequesr)
            .map(\.data)
            .decode(type: CinemaStarDTO.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink { complition in
                switch complition {
                case let .failure(error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { [unowned self] value in
                films = value.docs.map { FilmsCommonInfo(dto: $0) }
            }
            .store(in: &cancellable)
    }
}

// swiftlint:enable all
