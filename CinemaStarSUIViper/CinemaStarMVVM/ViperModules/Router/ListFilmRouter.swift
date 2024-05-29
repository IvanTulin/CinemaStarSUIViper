// ListFilmRouter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftUI

// Router
protocol ListFilmsRoutingProtocol {
    // func navigateToFilmDetails(withID id: String)
    func navigateToFilmDetails(withID id: Binding<String?>)
}

///

class ListFilmsRouter: ListFilmsRoutingProtocol {
    var view: ListFilmsView?
    var presenter: ListFilmsPresenter?

    func navigateToFilmDetails(withID id: Binding<String?>) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: DetailsFilmView(id: id))
            window.makeKeyAndVisible()
        }
    }

//    func navigateToFilmDetails(withID id: String) {
//        presenter?.showDetailsView(id: id)
//    }
}
