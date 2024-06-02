// InteractorTests.swift
// Copyright © RoadMap. All rights reserved.

@testable import CinemaStarMVVM
import Combine
import SwiftUI
import XCTest

final class InteractorTests: XCTestCase {
    var cancellablesSet: Set<AnyCancellable> = []

    func testFetchData() {
        let expectation = self.expectation(description: "data fetch")

        let interactor = MockInteractor()
        let router = ListFilmsRouter()
        let presenter = MockPresenter()
        interactor.presenter = presenter
        interactor.fetchFilms()

        interactor.$films
            .sink { value in
                XCTAssertFalse(value.isEmpty, "Данные приходят не корректно")

                if let firstFilm = value.first {
                    XCTAssertEqual(firstFilm.name, "Земля", "Названия фильма не совпадают")
                    XCTAssertEqual(firstFilm.rating, 8.316, "Рейтинг фильма не совпадает")
                    XCTAssertEqual(firstFilm.id, 4_707_110, "Нет такого Id фильма")
                } else {
                    XCTFail("Данные не соответствуют нужному значению")
                }
                expectation.fulfill()
            }
            .store(in: &cancellablesSet)

        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
