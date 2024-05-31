// DetailsFilmAssembly.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftUI

final class DetailsFilmAssembly {
    static func assemble(id: Binding<String?>) -> DetailsFilmView {
        let interactor = DetailsFilmInteractor()
        let router = DetailsFilmRouter()
        let presenter = DetailsFilmPresenter(interactor: interactor, router: router)
        let view = DetailsFilmView(id: id, presenter: presenter, detailsFilm: nil)
        // router.view = view
        presenter.detailsFilmView = view
        interactor.presenter = presenter
        return view
    }
}
