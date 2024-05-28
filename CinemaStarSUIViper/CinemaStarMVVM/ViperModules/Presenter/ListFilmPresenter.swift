// ListFilmPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation
import SwiftUI

///
protocol ListFilmsInteractorOutput: AnyObject {
    func fetchFilms()
}

///
final class ListFilmsPresenter: ListFilmsInteractorOutput, ObservableObject {
    //    @ObservedObject private var interactor = ListFilmsInteractor()
    @Published private var interactor: ListFilmsInteractor?
    @Published var films: [FilmsCommonInfo]?

    private let router: ListFilmsRoutingProtocol
    private var cancellable: Set<AnyCancellable> = []

    init(interactor: ListFilmsInteractor, router: ListFilmsRoutingProtocol) {
        self.router = router
        self.interactor = interactor

        interactor.$films
            .receive(on: RunLoop.main)
            .sink { [weak self] films in
                self?.films = films
            }
            .store(in: &cancellable)
    }

//    init() {
//        interactor.$films
//            .receive(on: RunLoop.main)
//            .sink { [weak self] films in
//                self?.films = films
//            }
//            .store(in: &cancellable)
//    }

    func fetchFilms() {
        interactor?.fetchFilms()
    }
}
