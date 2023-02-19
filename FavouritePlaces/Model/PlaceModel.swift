//
//  PlaceModel.swift
//  FavouritePlaces
//
//  Created by Сергей Бабич on 14.02.2023.
//

import UIKit

struct Place {
    let name: String
    let location: String
    let type: String
    let image: UIImage?
    let placeImage: String?

    static let placesNames = [
        "Aba", "WB", "Kari", "GreenHouse"
    ]

    static func getPlaces() -> [Place] {
        var places = [Place]()

        for place in placesNames {
            places.append(
                Place(name: place, location: "Baumana", type: "Bar", image: nil, placeImage: place)
            )
        }

        return places
    }
}
