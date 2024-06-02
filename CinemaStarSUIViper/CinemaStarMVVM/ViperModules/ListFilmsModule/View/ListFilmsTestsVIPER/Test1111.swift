// Test1111.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class Test1111 {
//    var interactor: MockInteractor2!
//    var mockPresenter: MockPresenter2!
//    var mockNetworkService: MockNetworkService2!
//    var cancellables: Set<AnyCancellable>!
//
//    override func setUpWithError() throws {
//        mockPresenter = MockPresenter2()
//        mockNetworkService = MockNetworkService2()
//        interactor = MockInteractor2()
//        interactor.presenter = mockPresenter
//        cancellables = []
//    }
//
//    override func tearDownWithError() throws {
//        interactor = nil
//        mockPresenter = nil
//        mockNetworkService = nil
//        cancellables = nil
//    }
//
//    func testFetchFilmsSuccess() {
//        // Подготовка
//        let dto = DocumentationDTO(
//            id: 4_707_110,
//            name: "Test Film",
//            poster: PosterDTO(url: ""),
//            rating: RatingDTO(kp: 8.316)
//        )
//        let expectedFilms = [FilmsCommonInfo(dto: dto)]
//        mockNetworkService.fetchFilmsResult = .success(expectedFilms)
//        let expectation = XCTestExpectation(description: "Fetch films and update presenter")
//
//        // Действие
//        interactor.fetchFilms()
//        mockPresenter.$films
//            .sink { films in
//                if films.count > 0 {
//                    expectation.fulfill()
//                }
//            }
//            .store(in: &cancellables)
//
//        wait(for: [expectation], timeout: 1.0)
//
//        // Проверка
//        XCTAssertTrue(mockPresenter.didLoadFilmCalled)
//        // XCTAssertEqual(mockPresenter.films, expectedFilms)
//    }
//
//    func testFetchFilmsFailure() {
//        // Подготовка
//        let expectedError = NSError(domain: "NetworkError", code: 0, userInfo: nil)
//        mockNetworkService.fetchFilmsResult = .failure(expectedError)
//        let expectation = XCTestExpectation(description: "Fetch films and handle error")
//
//        // Действие
//        interactor.fetchFilms()
//        mockPresenter.$error
//            .sink { error in
//                if error != nil {
//                    expectation.fulfill()
//                }
//            }
//            .store(in: &cancellables)
//
//        wait(for: [expectation], timeout: 1.0)
//
//        // Проверка
//        XCTAssertTrue(mockPresenter.didFailWithErrorCalled)
//        XCTAssertEqual(mockPresenter.error as NSError?, expectedError)
//    }
}
