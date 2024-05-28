// ListFilmRouter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Router
protocol ListFilmsRoutingProtocol {
    func navigateToFilmDetails(withID id: String)
}

///
class ListFilmsRouter: ListFilmsRoutingProtocol {
    var view: ListFilmsView?

    func navigateToFilmDetails(withID id: String) {
        // В SwiftUI навигация может быть выполнена через изменение состояния
        view?.selectedFilmId = id
        view?.isShowDetailView = true
    }
}
