// DetailsFilmViewModel2.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation

final class DetailsFilmViewModel2: ObservableObject {
    @Published var detailFilms: [DetailsFilmCommonInfo] = []

    private var requestCreator = RequestCreator()
    private var cancellable: Set<AnyCancellable> = []

    func fetch(id: String) {
        guard let urlRequesr = requestCreator.createDetailsFilmRequest(id: id) else { return }
        URLSession.shared.dataTaskPublisher(for: urlRequesr)
            .map(\.data)
            .decode(type: DetailsFilmDTO.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink { complition in
                switch complition {
                case let .failure(error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { [unowned self] value in
                detailFilms = [DetailsFilmCommonInfo(dto: value)]
            }
            .store(in: &cancellable)
    }
}
