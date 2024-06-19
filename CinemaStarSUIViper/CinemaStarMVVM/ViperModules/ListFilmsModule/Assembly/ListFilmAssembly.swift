// ListFilmAssembly.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Ассембли
final class ListFilmsAssembly {
    static func assemble() -> ListFilmsView {
        let interactor = ListFilmsInteractor()
        let router = ListFilmsRouter()
        let presenter = ListFilmsPresenter(interactor: interactor, router: router)
        let view = ListFilmsView(presenter: presenter)
        router.view = view
        presenter.listFilmView = view
        interactor.presenter = presenter
        return view
    }
}
