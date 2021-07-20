//
//  Activities.swift
//  HabitTracker
//
//  Created by Bruce Gilmour on 2021-07-16.
//

import Foundation

class Activities: ObservableObject {
    @Published var items = [Activity]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }

    init() {
        if let savedActivities = UserDefaults.standard.data(forKey: "Activities") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Activity].self, from: savedActivities) {
                items = decoded
                return
            }
        }
        items = []
    }
}


struct Activity: Identifiable, Codable {
    let id: UUID
    let name: String
    let categoryName: String
    let categoryImage: String
    let description: String
    let goodHabit: Bool
    var occurrences: Int
}

extension Activity {
    static let example1 = Activity(id: UUID(), name: "Tuba practice", categoryName: "Music", categoryImage: "music.note", description: "Practice breathing and scales\n\nMore text\n\nAnd some more", goodHabit: true, occurrences: 0)
    static let example2 = Activity(id: UUID(), name: "Attended rehearsal", categoryName: "Music", categoryImage: "music.note", description: "Times that I went to a band rehearsal", goodHabit: true, occurrences: 0)
    static let example3 = Activity(id: UUID(), name: "Missed rehearsal", categoryName: "Music", categoryImage: "music.note", description: "Times that I missed going to a band rehearsal", goodHabit: false, occurrences: 0)
}
