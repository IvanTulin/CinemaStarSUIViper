// Film+CoreDataProperties.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

public extension Film {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Film> {
        NSFetchRequest<Film>(entityName: "Film")
    }

    @NSManaged var id: Int64
    @NSManaged var name: String?
    @NSManaged var poster: String?
    @NSManaged var rating: Double
}

extension Film: Identifiable {}

extension Film {
    func toDTO() -> DocumentationDTO {
        DocumentationDTO(id: Int(id), name: name ?? "", poster: PosterDTO(url: poster), rating: RatingDTO(kp: rating))
    }
}
