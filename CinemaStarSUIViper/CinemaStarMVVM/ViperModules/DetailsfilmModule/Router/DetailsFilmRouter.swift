// DetailsFilmRouter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftUI

protocol DetailsFilmRouterProtocol {
    func navigateToListFilm()
}

final class DetailsFilmRouter: DetailsFilmRouterProtocol {
    func navigateToListFilm() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: ListFilmsAssembly.assemble())
            window.makeKeyAndVisible()
        }
    }
}
