// DetailsFilmRouter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftUI

/// Протокол для DetailsFilmRouter
protocol DetailsFilmRouterProtocol {
    func navigateToListFilm()
}

/// Роутер для перехода на экран  ListFilmsView  
final class DetailsFilmRouter: DetailsFilmRouterProtocol {
    func navigateToListFilm() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: ListFilmsAssembly.assemble())
            window.makeKeyAndVisible()
        }
    }
}
