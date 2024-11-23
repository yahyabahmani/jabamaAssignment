//
//  PlacesManager.swift
//  FiveSquare
//
//  Created by Shadi Ghelman on 11/23/24.
//

import Foundation
import Observation

@Observable
class PlaceManager {
    typealias Place = ListedPlacesMap.Model
    var places: [Place] = dummyPlaces()

    var isLoading: Bool { task?.isCancelled == false }
    var task: Task<Void, Error>?

    func onLastAppear() {
        guard task == nil else { return }

        task = Task {
            defer { task = nil }
            try await Task.sleep(for: .seconds(2))

            // TODO: Fetch next page from server
            places += Self.dummyPlaces()
        }
    }

    static func dummyPlaces() -> [Place] {
        (1...10).map {
            let randomName = UUID().uuidString.prefix(Int.random(in: 5...15))

            return .init(
                id: UUID().uuidString,
                name: String(randomName),
                type: "Restaurant",
                distance: $0 * 10,
                location: .init(
                    latitude: .random(in: 25...40),
                    longitude: .random(in: 48...60)
                )
            )
        }
    }
}
