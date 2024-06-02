// ListFilmInteractor.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import CoreData
import Foundation

// Interactor
protocol ListFilmsInteractorProtocol {
    func fetchFilms()
}

///
class ListFilmsInteractor: ListFilmsInteractorProtocol, ObservableObject {
    weak var presenter: ListFilmsPresenterProtocol?
    private var networkService = NetworkService2()
    private var cancellable: Set<AnyCancellable> = []
    private let coredataManager = CoreDataManager()

    func fetchFilms() {
        networkService.fetchFilms()
            .sink { completion in
                switch completion {
                case let .failure(error):
                    // Обработка ошибок, возможно уведомление Presenter
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] film in
                guard let self = self else { return }
                let cinemaCoreData = self.coredataManager.fetchFilmsFromCache()

                if cinemaCoreData.isEmpty {
                    self.coredataManager.saveCinema(cinema: film)
                    self.presenter?.didLoadFilm(films: film)
                } else {
                    self.presenter?.didLoadFilm(films: cinemaCoreData)
                }

                // self.presenter?.didLoadFilm(films: cinemaCoreData)
                // self.presenter?.didLoadFilm(films: film)
            }
            .store(in: &cancellable)
    }
}

extension ListFilmsInteractor {
//    func saveFilmsToCache(_ films: [FilmsCommonInfo]) {
//            let context = CoreDataManager.shared.context
//            films.forEach { filmInfo in
//                let filmEntity = Film(context: context)
//                filmEntity.id = Int64(filmInfo.id)
//                filmEntity.poster = filmInfo.poster
//                filmEntity.name = filmInfo.name
//                filmEntity.rating = filmInfo.rating
//            }
//            do {
//                try context.save()
//            } catch {
//                print("Failed to save films to cache: \(error)")
//            }
//        }
//
//        func fetchFilmsFromCache() -> [FilmsCommonInfo] {
//            let request: NSFetchRequest<Film> = Film.fetchRequest()
//            do {
//                let filmEntities = try CoreDataManager.shared.context.fetch(request)
//                return filmEntities.map { FilmsCommonInfo(dto: $0.toDocumentationDTO()) }
//            } catch {
//                print("Failed to fetch films from cache: \(error)")
//                return []
//            }
//        }
}
