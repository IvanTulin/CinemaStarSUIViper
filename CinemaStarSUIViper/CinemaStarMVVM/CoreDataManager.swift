// CoreDataManager.swift
// Copyright © IvanTulin. All rights reserved.

import CoreData
import Foundation
import SwiftUI

class CoreDataManager {
    static let shared = CoreDataManager()

    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
    }

    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }

    func saveCinema(cinema: [FilmsCommonInfo]) {
        guard let cinemaEntityDiscription = NSEntityDescription.entity(forEntityName: "Film", in: context)
        else { return }

        for filmInfo in cinema {
            let cinemaData = Film(entity: cinemaEntityDiscription, insertInto: context)
            cinemaData.id = Int64(filmInfo.id)
            cinemaData.name = filmInfo.name
            cinemaData.poster = filmInfo.poster
            cinemaData.rating = filmInfo.rating
        }
        appDelegate.saveContext()
    }

//    func fetchFilmsFromCache() -> [FilmsCommonInfo] {
//        let fetchRequest: NSFetchRequest<Film> = Film.fetchRequest()
//        var cinemas: [FilmsCommonInfo] = []
//        do {
//            let cinema = try context.fetch(fetchRequest)
//            for item in cinema {
//                let cinema = FilmsCommonInfo(dto: item.toDTO())
//                cinemas.append(cinema)
//            }
//        } catch {
//            print("Failed to fetch films from cache: \(error)")
//            return []
//        }
//        return cinemas
//    }

    func fetchFilmsFromCache() -> [FilmsCommonInfo] {
        let fetchRequest: NSFetchRequest<Film> = Film.fetchRequest()
        var cinemas: [FilmsCommonInfo] = []
        var uniqueIds = Set<Int64>()

        do {
            let fetchedCinemas = try context.fetch(fetchRequest)
            for item in fetchedCinemas where !uniqueIds.contains(item.id) {
                let cinema = FilmsCommonInfo(dto: item.toDTO())
                uniqueIds.insert(item.id)
                cinemas.append(cinema)
            }
        } catch {
            print("Failed to fetch films from cache: \(error)")
            return []
        }
        return cinemas
    }

//    func fetchFilmsFromCache() -> [FilmsCommonInfo] {
//                let request: NSFetchRequest<Film> = Film.fetchRequest()
//                do {
//                    let filmEntities = try context.fetch(request)
//                    return filmEntities.map { FilmsCommonInfo(dto: $0.toDTO()) }
//                } catch {
//                    print("Failed to fetch films from cache: \(error)")
//                    return []
//                }
//            }

//     func fetchCinema() -> [FilmsCommonInfo] {
//         let fetchRequest: NSFetchRequest<Film> = Film.fetchRequest()
//         var cinemas: [FilmsCommonInfo] = []
//         do {
//             let cinema = try context.fetch(fetchRequest)
//             for item in cinema {
//                 let cinema = FilmsCommonInfo(dto: Doc(
//                     name: item.name ?? "",
//                     poster: Backdrop(url: item.poster ?? "", previewURL: ""),
//                     rating: Rating(kp: Double(item.raiting)),
//                     id: Int(item.id)
//                 ))
//                 cinemas.append(cinema)
//             }
//         } catch {
//             return []
//         }
//         return cinemas
//     }
}

// class CoreDataManager {
//    static let shared = CoreDataManager()
//
//    private init() {}
//
//    private var appDelegate: AppDelegate {
//        UIApplication.shared.delegate as! AppDelegate
//    }
//
//    private var context: NSManagedObjectContext {
//        appDelegate.persistentContainer.viewContext
//    }
// }
