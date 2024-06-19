// ListFilmRouter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftUI

/// Протокол для ListFilmsRouter
protocol ListFilmsRoutingProtocol {
    func navigateToFilmDetails(withID id: Binding<String?>)
}

/// Роутер для перехода на экран DetailsFilmView
final class ListFilmsRouter: ListFilmsRoutingProtocol {
    var view: ListFilmsView?
    var presenter: ListFilmsPresenter?

    func navigateToFilmDetails(withID id: Binding<String?>) {
        if let window = UIApplication.shared.windows.first {
            // window.rootViewController = UIHostingController(rootView: DetailsFilmView(id: id))
            window.rootViewController = UIHostingController(rootView: DetailsFilmAssembly.assemble(id: id))
            window.makeKeyAndVisible()
        }
    }
}
